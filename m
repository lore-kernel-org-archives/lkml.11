Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53FF2C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Feb 2022 04:16:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343725AbiBUEQu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Feb 2022 23:16:50 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343711AbiBUEQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 23:16:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 363F94A3E4;
        Sun, 20 Feb 2022 20:16:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EA1F4B80D03;
        Mon, 21 Feb 2022 04:16:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDD3EC340E9;
        Mon, 21 Feb 2022 04:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645416982;
        bh=couWPsTXfJEh+xmhZp6gZEZnKAjYzyuqYya7S8YW/+w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VvPbaL0AFSBZHxA3BwXZf1ihw4TZKPRGYwYCw2PmGYOo46DJE2tnOQPeBpFGlzDif
         W1B1MLLDQADmypVeiX5l6weSmy1SCDMXGgWc+KZyMdSNdD6IUWCEOoPkKToXWUKa6Q
         BsLemZVoT9jExNuE40m+4GAx7k3Qz572Nttbog137Cl4rx3gu1nBOrk4gzGsBbo3bM
         fqPVDgHujgHn1HV25KDC6dTvH9ncZopEDENwlWqsvZdSNNuDOl3Bix+VZMulhD4wx3
         y40FruDkubkYe05ccLviXYIl9YtJydM0DRmPCr/ObMx3kqqr7bf4axg3ZEhW8cqjBy
         pt06j5Qn/+TYA==
Date:   Mon, 21 Feb 2022 12:16:17 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/4] imx8mm-venice: add dt overlays
Message-ID: <20220221041617.GK2249@dragon>
References: <20220214231424.30927-1-tharvey@gateworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220214231424.30927-1-tharvey@gateworks.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 14, 2022 at 03:14:20PM -0800, Tim Harvey wrote:
> Combined several overlay patches into a single series.
> 
> Tim Harvey (4):
>   arm64: dts: imx8mm-venice-gw73xx-0x: add dt overlays for serial modes
>   arm64: dts: imx8mm-venice-gw72xx-0x: add dt overlays for serial modes
>   arm64: dts: imx8mm-venice-gw73xx-0x: add dt overlay for imx219 rpi v2
>     camera
>   arm64: dts: imx8mm-venice-gw72xx-0x: add dt overlay for imx219 rpi v2
>     camera

Applied all, thanks!
