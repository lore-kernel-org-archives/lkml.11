Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E469C433EF
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Jul 2022 07:29:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231307AbiGEH3e (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Jul 2022 03:29:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230398AbiGEH3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 03:29:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1F5512619
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 00:29:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A2064B81630
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 07:29:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD031C341C7;
        Tue,  5 Jul 2022 07:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657006170;
        bh=jr/lmjA+fvU99wtt1/ZC+0QddPrMA3HHsWrLCoegLS8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=roeG4vDZmtGMKNQkqGUEO9Vr9+fM/R1ljJpLNsPc0p/KUaEtBTsqhzPLT8EbMGbcq
         LmQRDTPHS/7cdGfWGQ2iEnvNbB5Z9XYbydSaWAAi6a8YJkQDXVFWvx7GChSkvkU0uL
         joM7tAaG7R9vJ2u8qCOLDnvU3q5LxisXtwcHz6Bt7kq7VJWG3g13hm4ERGyhMDoNbm
         eu6nT2syDMkdXt+EPuo64HsdWi2QbyzVGI3ADwyRQPhL+Y685eaxrRYDp1MqLmaPRz
         7YmJw/9yBlDCIutYAZ62da1dgAC/k75Rtv4zR21x1hw4iOW257l4fel3JRibiaBkL6
         LQYxKBElBTibQ==
Date:   Tue, 5 Jul 2022 12:59:26 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Jiang Jian <jiangjian@cdjrlc.com>
Cc:     alcooperx@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        kishon@ti.com, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org
Subject: Re: [PATCH] phy: phy-brcm-usb: drop unexpected word "the" in the
 comments
Message-ID: <YsPoVjodZ81vAGvu@matsya>
References: <20220621122401.115500-1-jiangjian@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220621122401.115500-1-jiangjian@cdjrlc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-06-22, 20:24, Jiang Jian wrote:
> there is an unexpected word "the" in the comments that need to be dropped

Applied, thanks

-- 
~Vinod
