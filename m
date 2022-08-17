Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 773DAC32771
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Aug 2022 13:02:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236810AbiHQNCT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Aug 2022 09:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239517AbiHQNCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 09:02:15 -0400
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 107D350192
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 06:02:13 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-606-NZQ4NCOoN3WASB5cMubqUA-1; Wed, 17 Aug 2022 09:02:07 -0400
X-MC-Unique: NZQ4NCOoN3WASB5cMubqUA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 870968039B9;
        Wed, 17 Aug 2022 13:02:06 +0000 (UTC)
Received: from hog (unknown [10.39.193.238])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 836AAC15BB3;
        Wed, 17 Aug 2022 13:02:04 +0000 (UTC)
Date:   Wed, 17 Aug 2022 15:01:56 +0200
From:   Sabrina Dubroca <sd@queasysnail.net>
To:     Emeel Hakim <ehakim@nvidia.com>
Cc:     edumazet@google.com, mayflowerera@gmail.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Raed Salem <raeds@nvidia.com>
Subject: Re: [PATCH net-next 1/1] net: macsec: Expose MACSEC_SALT_LEN
 definition to user space
Message-ID: <YvzmxKnQ7pMg0KxF@hog>
References: <20220817105815.8712-1-ehakim@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220817105815.8712-1-ehakim@nvidia.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2022-08-17, 13:58:15 +0300, Emeel Hakim wrote:
> Expose MACSEC_SALT_LEN definition to user space to be
> used in various user space applications such as iproute.
> Iprotue will use this as part of adding macsec extended

nit: spelling of "Iproute"

Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>

-- 
Sabrina

