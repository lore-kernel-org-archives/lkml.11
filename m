Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 659DDC43334
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jun 2022 07:21:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232815AbiF0HVt (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jun 2022 03:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232665AbiF0HVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 03:21:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 542165592;
        Mon, 27 Jun 2022 00:21:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 00616B80E7B;
        Mon, 27 Jun 2022 07:21:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A560C341C8;
        Mon, 27 Jun 2022 07:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656314502;
        bh=aeEvKf5kFUv5FecyMUoquEQPzC1Qa44RnkFd+Gc+dqY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s9B0tj02+sDGrqd9e2QVk6Q+3G28F4Y8mQj06DZ635oqtHoMtiv8kajb797y2iLz2
         vzCuJVHdlby+T9P7bp1ROaKes5D5w8zsvwKGKPfP1I28VybrfNX64qBYLJmqI4J7gu
         QAj8jtk4vVImnnwE0tMyTgk4ptYpfRpmT8RjLaIb4PtxYGpJQF1cReSBWdyPW0E0/3
         blOo5cK050hjGX9QSAngSJPib9VYXizhp7tkRymKeZEFjITqFZublI8A0snUte0qVa
         a/sWhHTA348TKOf9SU21HbzP+bZeDDXguJy+NwrMRzLkIy2kFD1YMeAkIsvK4x8cG/
         7fOClYKTLy9sw==
Date:   Mon, 27 Jun 2022 15:21:35 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        s.hauer@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        laurent.pinchart@ideasonboard.com, paul.elder@ideasonboard.com,
        marex@denx.de, aford173@gmail.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH] arm64: dts: imx8mp: correct clock of pgc_ispdwp
Message-ID: <20220627072135.GB819983@dragon>
References: <20220620032044.4093226-1-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220620032044.4093226-1-peng.fan@oss.nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 20, 2022 at 11:20:44AM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> The deprecated DIV clk is previously part of the ISP composite clk, but
> there is still one child clk(IMX8MP_CLK_MEDIA_ISP_ROOT) sourcing from
> IMX8MP_CLK_MEDIA_ISP( previously IMX8MP_CLK_MEDIA_ISP_DIV)
> 
> So IMX8MP_CLK_MEDIA_ISP_ROOT should be used, not IMX8MP_CLK_MEDIA_ISP_DIV.
> 
> Fixes: 9d89189d5227 ("arm64: dts: imx8mp: Add MEDIAMIX power domains")
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Applied, thanks!
