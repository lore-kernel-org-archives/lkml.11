Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F8DCC433FE
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Apr 2022 10:15:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238771AbiDIKRH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Apr 2022 06:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235928AbiDIKRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 06:17:04 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C885A94FD;
        Sat,  9 Apr 2022 03:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1649499268;
        bh=tXMARNLA9DskS7n6l1+tRTujZqGhAZ7GRbPO4UYdPRc=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=IxSVxP90+ZOmEBXLIuvHmUe8+W6ei5skmLQXA7D97rKvQTmB1HlhHuQzya5Yc3erI
         a4798YOY7L2qJg8puehOsBOnv36HJ6akGys1S2MAcHXvqbQILDQOCj+EPW9lpx/Tfa
         KTS5JqqSY/+YGD9UtdBeuYAVK95UoxO8NbgABKPQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [217.61.154.105] ([217.61.154.105]) by web-mail.gmx.net
 (3c-app-gmx-bap35.server.lan [172.19.172.105]) (via HTTP); Sat, 9 Apr 2022
 12:14:28 +0200
MIME-Version: 1.0
Message-ID: <trinity-71c38625-1a00-47d7-8e23-4f33f25a997a-1649499268581@3c-app-gmx-bap35>
From:   Frank Wunderlich <frank-w@public-files.de>
To:     Frank Wunderlich <linux@fw-web.de>
Cc:     linux-rockchip@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Peter Geis <pgwipeout@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Aw: [PATCH] arm64: dts: rockchip: Fix clocks for rk356x usb
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 9 Apr 2022 12:14:28 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <20220409075147.136187-1-linux@fw-web.de>
References: <20220409075147.136187-1-linux@fw-web.de>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:px9Dl30mP0/QOKo5gWzMbk3rYhC07nGJKO5T6E1xcDiNxsLeEdTFjFjjF9hbV99UMwwOW
 FwsyR+UdSAMRyI9aPH/Q6jkHGxs++t0sjrecW51r265jC8FaAzWna4EvOweafGBa8wV7lxQCR8lK
 mMqTSEa/3iLVxAoTe+d9pQAaRj/LtPCzYBm8WU3gSxC0uusrCPmxpyNFt60RaCUk2P4PUl1GdVIS
 xfJhmMq/kaBHACzFky3DPOQFDCaBGLNvnFj6Pi9KWopYtHc41FWM0FDEnxujYzJhut6xutjtuSto
 CE=
X-UI-Out-Filterresults: notjunk:1;V03:K0:zbENke1MzTM=:YR0ppS2dMTPhcmVvRBMzNt
 piE5Zy31YYywszrY6CK3nUaGlIobuQ0u5wtqrfaYKCmsYa5XHeWAetWC8ZUDShk1UjsmYxN2C
 BzoPrkLehp7/2eSS8rhVpnetpbNTr0wXLTeWwSvWUe8UB9uWEiqVnD1vHGvg6uE/l4bs5QfTm
 KgmCSUo7wcte/A/gJuQQ4iKiOdtmUxciJXekT0ZVMKzdlrBK2hKCNI71AuYI86swJYCan1/zk
 P998W6ZVyQ7eJL2UCk2CC/yb7gAloyGMewbEkCuVm4bBJ99KdAi6FR97RQEmPNquywD+j9/4T
 yxUZzRIbu+RU77lGc5JFMvx7YwQXFGOnZr6utyObmoU/rwCB78vcqeJZV3Xx11M9DB52uL7ct
 iZDbH4D5tS5VfNru8L1sQ1N85oWJy8uuSG7+mYlqMrQGkw/nSZv8eg7+dJttjNaWggij3aer1
 KSTDRwN32q7aTwoZy8RK9Huw/Co88LYYdpOfnMwIzb+dU0xLNoWd0wzfP8imZepslZW6JuuAE
 26xMizivLHaBBjqchgeYAhHGhn2+q793SoupccWjuffQRtz7R73Gsn0hZy3fUC/GBBZgt3K9h
 Ig0cz8Dlblg0XWQb/SrcMC1hRqvN9uYmyXVn55hxEEOm1ESAFirVN/BIKqlG8tOBX/OfRkTyc
 yd1lJSCcg97t18vPJZfl1UVv1dwmxO2wcFcEk6d8+b+RZLpbt2plEglXBqlFLTInZHw5XXSIJ
 bhvWeAq0BZNgRFwwbJWiPogMgNZrNohOlNfcs2ctzZ3AeAo8cKPUIBwjKsITNPhM1yYQWcNbv
 zjcSJP8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> Gesendet: Samstag, 09. April 2022 um 09:51 Uhr
> Von: "Frank Wunderlich" <linux@fw-web.de>

> -		clock-names = "ref_clk", "suspend_clk",
> -			      "bus_clk";
> +		clock-names = "ref", "suspend_clk",
> +			      "bus_early";
>  		dr_mode = "host";
>  		phy_type = "utmi_wide";
>  		power-domains = <&power RK3568_PD_PIPE>;
> @@ -280,8 +280,8 @@ usb_host1_xhci: usb@fd000000 {
>  		interrupts = <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>;
>  		clocks = <&cru CLK_USB3OTG1_REF>, <&cru CLK_USB3OTG1_SUSPEND>,
>  			 <&cru ACLK_USB3OTG1>;
> -		clock-names = "ref_clk", "suspend_clk",
> -			      "bus_clk";
> +		clock-names = "ref", "suspend_clk",
> +			      "bus_early";
>  		dr_mode = "host";

this is the patch breaking it:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=33fb697ec7e58c4f9b6a68d2786441189cd2df92

suspend clock needs to be renamed too from "suspend_clk" to "suspend"

else i get this error on poweroff

xhci-hcd xhci-hcd.1.auto: Host halt failed, -110

regards Frank
