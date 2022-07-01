Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCB2CC43334
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Jul 2022 03:20:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234044AbiGADUi (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jun 2022 23:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233910AbiGADUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 23:20:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BA6B64D51;
        Thu, 30 Jun 2022 20:20:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DF42562267;
        Fri,  1 Jul 2022 03:20:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFA5FC341C7;
        Fri,  1 Jul 2022 03:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656645634;
        bh=IvyzASJDJxUv2jU8d10Xceu+Vc/X5pixWqUZCtYeUPM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ad29WydLF9KycKeOhvUt2Z73YZiFX8YFxIlZXkQRvK4DJ2d05bABtTV6AVN824M5n
         DYiaRcnzsTfnlOGFX/me4XR2hZgtNlym0xkHy8PY6669LQ+DR56k8RGIePBlv4VzmL
         WSv/oJrxLD64e6ZXhbJbvx7J/StgZV+X4SPxnfcOI1PeV7XzV+dkBrY8wneybRufqL
         oFXle18fno0L66iK1ni7VahPmx4KeARcTbP9wW0IKtW67xQXyA2kblE9qUYmhCoxeE
         ubnBLT8iHiNjdz2uYLJoFWsSM+d43PQ8AhNVkfegGNaxYKvyBcFSOwZTrGY+8P5Huj
         XdgXpDdpcGYyQ==
Date:   Thu, 30 Jun 2022 20:20:32 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Divya Koppera <Divya.Koppera@microchip.com>
Cc:     <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
        <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <devicetree@vger.kernel.org>, <UNGLinuxDriver@microchip.com>,
        <Madhuri.Sripada@microchip.com>
Subject: Re: [PATCH v2 net-next 2/2] net: phy: micrel: Adding LED feature
 for LAN8814 PHY
Message-ID: <20220630202032.3344c412@kernel.org>
In-Reply-To: <20220629085800.11600-3-Divya.Koppera@microchip.com>
References: <20220629085800.11600-1-Divya.Koppera@microchip.com>
        <20220629085800.11600-3-Divya.Koppera@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Jun 2022 14:28:00 +0530 Divya Koppera wrote:
> LED support for extended mode where
> LED 1: Enhanced Mode 5 (10M/1000M/Activity)
> LED 2: Enhanced Mode 4 (100M/1000M/Activity)
> 
> By default it supports KSZ9031 LED mode
> 
> Signed-off-by: Divya Koppera <Divya.Koppera@microchip.com>

This severely does not build..
Please make sure build with W=1 C=1 is clean.
