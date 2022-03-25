Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 075B4C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Mar 2022 12:54:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359184AbiCYMzq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Mar 2022 08:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238986AbiCYMzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 08:55:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 290A9931B3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 05:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648212847;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WhhWwWg4FCTKQgANTQEkU3eik+mebp4qX/dh9cAxltc=;
        b=ivxOqLfL1fB7QrazicwN73nhprJoOxIYrsTW+EyTx5xo7ljOPHUrl75ZHUC2eEB9TgMZFr
        0oaZZPSwQTKZU4ZY9+tQUk18/emazGhy0YbN8oJFFeR6dU32rWmLsHT7Vft5mDaaPPDW5g
        NuW5eLQEmAoPxEocWHK0j6xSszWq6Sg=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-577-vrMoUzvJN5Kjtvk0lT1KnQ-1; Fri, 25 Mar 2022 08:54:02 -0400
X-MC-Unique: vrMoUzvJN5Kjtvk0lT1KnQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8D7DD381D8A9;
        Fri, 25 Mar 2022 12:53:55 +0000 (UTC)
Received: from ceranb (unknown [10.40.192.65])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AE3E42024CD2;
        Fri, 25 Mar 2022 12:53:39 +0000 (UTC)
Date:   Fri, 25 Mar 2022 13:53:37 +0100
From:   Ivan Vecera <ivecera@redhat.com>
To:     Marcin Szycik <marcin.szycik@linux.intel.com>
Cc:     netdev@vger.kernel.org, poros@redhat.com, mschmidt@redhat.com,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Akeem G Abodunrin <akeem.g.abodunrin@intel.com>,
        Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>,
        "moderated list:INTEL ETHERNET DRIVERS" 
        <intel-wired-lan@lists.osuosl.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] ice: Fix broken IFF_ALLMULTI handling
Message-ID: <20220325135337.2091ba08@ceranb>
In-Reply-To: <eb6538d9-4667-f1f5-492c-e1e113a6da35@linux.intel.com>
References: <20220321191731.2596414-1-ivecera@redhat.com>
        <eb6538d9-4667-f1f5-492c-e1e113a6da35@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Mar 2022 21:05:20 +0100
Marcin Szycik <marcin.szycik@linux.intel.com> wrote:

> > @@ -352,29 +359,15 @@ static int ice_vsi_sync_fltr(struct ice_vsi *vsi)
> >  	/* check for changes in promiscuous modes */
> >  	if (changed_flags & IFF_ALLMULTI) {
> >  		if (vsi->current_netdev_flags & IFF_ALLMULTI) {
> > -			if (vsi->num_vlan > 1)
> > -				promisc_m = ICE_MCAST_VLAN_PROMISC_BITS;
> > -			else
> > -				promisc_m = ICE_MCAST_PROMISC_BITS;  
> 
> Because `ice_{set,clear}_promisc()` are now always called with the same second argument (ICE_MCAST_PROMISC_BITS), wouldn't it be better to remove the arg and instead call `ice_fltr_{clear,set}_{vlan,vsi}_vsi_promisc()` with either ICE_MCAST_VLAN_PROMISC_BITS or ICE_MCAST_PROMISC_BITS inside the function?

Because ice_{set,clear}_promisc() then could be used only for set mcast prosmisc mode so I modified them only to automatically insert ICE_PROMISC_VLAN_RX & ICE_PROMISC_VLAN_TX based on vsi->num_vlan value.

Anyway I will fix some objections from Jacob and send v2.

Thanks,
Ivan

