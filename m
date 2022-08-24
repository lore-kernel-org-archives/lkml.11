Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74CD3C00140
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Aug 2022 10:12:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236177AbiHXKMM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Aug 2022 06:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234777AbiHXKMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 06:12:09 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09E3D5F131
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 03:12:07 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id AD1EF20338;
        Wed, 24 Aug 2022 10:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1661335925; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yFQ5Xj0Afln1X3Eg8TaYOZg1uw570beqAjxgfFWtDhE=;
        b=Pz9YrIBkCgbE3L99i3dZUErz3S7PWmccCkMLbL7iJ/zaRkFsB87FjCjuaCdb+ywFxlymr+
        Ty19JhoCAc8HOM9o6Hdiv9rZRz+qr/Q+jSfBKREm9j6N8AAewF+PQO3Tt98MyKuaAa6hR4
        gKzefkNuJi6VD63TUbkHfMsJTyirzjQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8A5C913AC0;
        Wed, 24 Aug 2022 10:12:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id uxj+HnX5BWO+FAAAMHmgww
        (envelope-from <mhocko@suse.com>); Wed, 24 Aug 2022 10:12:05 +0000
Date:   Wed, 24 Aug 2022 12:12:04 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Liu Shixin <liushixin2@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        huang ying <huang.ying.caritas@gmail.com>,
        Aaron Lu <aaron.lu@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Kemi Wang <kemi.wang@intel.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH -next v2] mm, proc: collect percpu free pages into the
 free pages
Message-ID: <YwX5dL8P9nxVtR1G@dhcp22.suse.cz>
References: <20220822023311.909316-1-liushixin2@huawei.com>
 <20220822033354.952849-1-liushixin2@huawei.com>
 <20220822141207.24ff7252913a62f80ea55e90@linux-foundation.org>
 <YwSGqtEICW5AlhWr@dhcp22.suse.cz>
 <6b2977fc-1e4a-f3d4-db24-7c4699e0773f@huawei.com>
 <YwTYMGtcS4/F/xQO@dhcp22.suse.cz>
 <cd84777e-b7d9-7e7e-2121-9d75eeb950cb@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd84777e-b7d9-7e7e-2121-9d75eeb950cb@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 24-08-22 18:05:58, Liu Shixin wrote:
[...]
> But since these memory is also free memory that can be uesd and is large, I think we
> should still provide a statistic for the user. Perhaps add a new statistic is better?

Well, if somebody is really interested then /proc/zoneinfo gives a very
detailed insight into pcp usage.
-- 
Michal Hocko
SUSE Labs
