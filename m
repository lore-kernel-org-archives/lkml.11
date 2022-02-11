Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4717FC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Feb 2022 09:15:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348411AbiBKJPg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Feb 2022 04:15:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235530AbiBKJPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 04:15:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 784BD102D;
        Fri, 11 Feb 2022 01:15:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 13CE261EAB;
        Fri, 11 Feb 2022 09:15:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA570C340E9;
        Fri, 11 Feb 2022 09:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644570930;
        bh=QTZP8fqHHC1+Y2mhadMmJp6T7ga9jtD4xF9Z0QYiPSQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aZ/YUWnhWWOBYxozzvnRQG10LeoqFwxlFQsLVYXgo0fTxUlJUWK8sMcJeBb1O4Amf
         GXKJyAk90xQhrEqSsH/ibRzDoLf+hAFXpwACpeyZFMWta/Erm28GXQuBCbDA2DGpVu
         lazI0vnF1l2CPrxQAnEXElaV8/ZoSgHG0uT8SIS1DWQihFjGGaObZV3tjV1t1IIeHq
         Uz3wrXeIOeNinkzGW9vb1+mtdVg6bMcJ5Fsvv9a0ydym5MozZactOkM/mMRv9/WQuS
         2UB8vMIaU3MeZmuAH99gfptZ7AfzUcdt8Nz4eDDcr2mtWp3PdffZRK8SwZB8ynlpKn
         fHScQCykTYe2Q==
Date:   Fri, 11 Feb 2022 17:15:24 +0800
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
Subject: Re: [PATCH v2] arm64: dts: imx8mp-evk: add PCA6416 interrupt
 controller mode
Message-ID: <20220211091524.GT4909@dragon>
References: <20220129060818.GQ4686@dragon>
 <20220129202617.2332885-1-hugo@hugovil.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220129202617.2332885-1-hugo@hugovil.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 29, 2022 at 03:26:17PM -0500, Hugo Villeneuve wrote:
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> 
> Add interrupt controller mode for the pca6416 on i.MX8MP EVK board's.
> 
> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Applied, thanks!
