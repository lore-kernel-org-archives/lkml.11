Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 971AFC25B08
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Aug 2022 18:58:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243717AbiHHS6L (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Aug 2022 14:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243462AbiHHS56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 14:57:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ECF71834C;
        Mon,  8 Aug 2022 11:57:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 52355B81058;
        Mon,  8 Aug 2022 18:57:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBB66C433D6;
        Mon,  8 Aug 2022 18:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659985075;
        bh=bH+lqvWoXJ5G48TLV2MmhA+z+Crq8ErWotkdCn4RC7k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nj4yBpXoAX1vL5/hd4m8EC2wR8O2gz2BEXJ4lKEFUxPjH0gZp5cRYV9+jY5FhPKIo
         kyAJwDPJTPVAPbYTI8nQEnXlkWz+ejnrgyUbkvMpVKE8a1K4scZyPsuQ9ROfk/Xqe2
         4sVm1ZVt29Cqs/WNogty9s8aTa4fZ6PT5QTVq/QFxLmZ0GNQw82yRxXvB6+ZJ5wTMt
         ZqcfYQ3xsC1sLpHnt7Y3kYWHd+xUtMbacLuosD6MDm5Gqhwls1QimKKNI29J/BiV9l
         n2F3f1yIoBLp+SvESGjfQpRTZPCE0bjReEI71ktBQJzv8EjVoVTX+FbaFRI12M9xX8
         AcS5NYOUmMnww==
Date:   Mon, 8 Aug 2022 11:57:53 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Chunhao Lin <hau@realtek.com>
Cc:     <netdev@vger.kernel.org>, <nic_swsd@realtek.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 net-next] r8169: add support for rtl8168h(revid 0x2a)
 + rtl8211fs fiber application
Message-ID: <20220808115753.1441dbe1@kernel.org>
In-Reply-To: <20220808163929.4068-1-hau@realtek.com>
References: <20220808163929.4068-1-hau@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Aug 2022 00:39:29 +0800 Chunhao Lin wrote:
> rtl8168h(revid 0x2a) + rtl8211fs is for fiber related application.
> rtl8168h is connected to rtl8211fs mdio bus via its eeprom or gpio pins.
> In this patch, use bitbanged MDIO framework to access rtl8211fs.
> 
> Signed-off-by: Chunhao Lin <hau@realtek.com>

You must CC the maintainers of the driver you're making changes to.
Also:

# Form letter - net-next is closed

We have already sent the networking pull request for 6.0
and therefore net-next is closed for new drivers, features,
code refactoring and optimizations. We are currently accepting
bug fixes only.

Please repost when net-next reopens after 6.0-rc1 is cut.

RFC patches sent for review only are obviously welcome at any time.
