Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C0EDC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Feb 2022 03:18:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344047AbiBUDTS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Feb 2022 22:19:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243851AbiBUDTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 22:19:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6346941338;
        Sun, 20 Feb 2022 19:18:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0100961146;
        Mon, 21 Feb 2022 03:18:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E05DC340E8;
        Mon, 21 Feb 2022 03:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645413533;
        bh=tFZY47k1wlpn3B0+vLhc1TDaBr/PKYDV9fUj0ENKa8U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uwxamCAyroaxwRfEDfBmuKBL/WA7lOeG03PQpm9fNIzdRNusomAC336ru2xwtaMt3
         3svUUWgQv57YjrtmJLfg/h3NPvsRCa4ufIYaDfwPxs0Xu5XbhLBMrzI5ma24e885/b
         I4VHFB7PYaamu83lItZB4fC4nl3Z2ia9xn+F1Q+CBqze70AlA03kFLKyTq0DOCtwTU
         d9C/OMYL67j40YGjuU2CN8AVEpocqW5EQPTcSuTy5wdnJCyJgK6XfVf/tazgnVMUdo
         YkwjRiVow8nENigMmXU5NNhoDD4zQ+EswjZlzEgT3vPI5GmbqdKmLrN+hjRFGAoHmZ
         qj5Eij3K+AgMA==
Date:   Mon, 21 Feb 2022 11:18:47 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: imx8mp-evk: add PCA6416 gpio line names
Message-ID: <20220221031847.GF2249@dragon>
References: <20220211153818.3721541-1-hugo@hugovil.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220211153818.3721541-1-hugo@hugovil.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 11, 2022 at 10:38:17AM -0500, Hugo Villeneuve wrote:
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> 
> Add gpio-line-names for the various GPIO's connected to the PCA6416
> I/O expander on the imx8mp EVK.
> 
> This helps when using the new gpiod interface to find the GPIOs by name.
> 
> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Applied, thanks!
