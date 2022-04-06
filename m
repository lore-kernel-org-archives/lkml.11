Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84FBBC433EF
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Apr 2022 15:57:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236935AbiDFP7a (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Apr 2022 11:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237199AbiDFP57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 11:57:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E1763878E4;
        Wed,  6 Apr 2022 06:24:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C2610B823C7;
        Wed,  6 Apr 2022 13:24:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0213AC385A1;
        Wed,  6 Apr 2022 13:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649251457;
        bh=9iYA/HOkMsWd89xBB9FdVueeuaKg1IVIScRynNGasXk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Wpaqx5OrP/4ZKQO7wVVNRivuU9PduzghP7WZFdbFV1oWuzboEOjXWlHlw1i+uF4Ls
         /j61ifCOE8Rjo5NM/5Z17bQ7EmY+v+/L+r92Bw11OGpb8oojwLOf4q1I/HClI8uOG+
         Yp6I/Nnv2fg/oC7WlSpYYDnHoNN37hmMpek58gTzEADadSK/dP9Xd7DICdBofEJG7B
         790vgg5v93oORrpnbzuSsTLW0cQ7KOKCzxhXLe8g+j9t7rW1GvdsixESie1v2xpuZL
         7i/vo78aL3JUrSlTRzeV5hj4aevp2HDHLkv/dlTbec3/WjnBaBp5T3tU4j+sjKU++J
         hlxVKMxLo9wPg==
Date:   Wed, 6 Apr 2022 21:24:10 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     sboyd@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de,
        abel.vesa@nxp.com, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 1/2] arm64: dts: imx8mq: add hdmi phy 27m clock
Message-ID: <20220406132410.GS129381@dragon>
References: <20220225090002.2497057-1-peng.fan@oss.nxp.com>
 <20220225090002.2497057-2-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220225090002.2497057-2-peng.fan@oss.nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 25, 2022 at 05:00:01PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> The i.MX8MQ PLL support hdmi phy 27m as pll reference clock,
> so add a fixed clock for it.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Applied, thanks!
