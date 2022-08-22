Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 575B1C00140
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Aug 2022 01:55:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232116AbiHVBzf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Aug 2022 21:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231923AbiHVBz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 21:55:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEC3411825;
        Sun, 21 Aug 2022 18:55:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5B58060B06;
        Mon, 22 Aug 2022 01:55:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D36B5C433D6;
        Mon, 22 Aug 2022 01:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661133324;
        bh=ZkHFQhcxxS6N+sD2EjkQjdQx8MeJSe36GS9cFd5HSzE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SxMv9kq6cUEQewgpbvS7kr6zLil2OVXBrIckUFjVBpK2Y0exhH+M6S4q/C4rm0hnD
         SIiPgYPTm3ytHtQ6HLarq9nC1fCX5CdYYtEvuGzWDkUBLgzFktbzAUWchsB4nccJGN
         aglVuCf2e10DjinTHVYrYE2YmAdvQD9fT7cS+IQ3fAkhf/rpW1E4+kL6fq3mH01g6G
         4XVAoaIy+4ktmcBTrXFE6SU0PHDMhj5Zl+KZOJZ4Wuoqvqxq60N5x4xp9Mvzn11KQ/
         a58ZTn2u8KG1IWAxZdPbU4ouRSx/Pp6DrrYYPrwWPd7FS4Ly9qyKR7c4uyrlsCZYUu
         JzSfh+iQHLCvA==
Date:   Mon, 22 Aug 2022 09:55:18 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: imx8mm-venice-gw7901: fix port/phy validation
Message-ID: <20220822015518.GI149610@dragon>
References: <20220812172054.13858-1-tharvey@gateworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220812172054.13858-1-tharvey@gateworks.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 12, 2022 at 10:20:54AM -0700, Tim Harvey wrote:
> Since commit 65ac79e18120 ("net: dsa: microchip: add the phylink
> get_caps") the phy-mode must be set otherwise the switch driver will
> assume "NA" mode and invalidate the port.
> 
> Fixes: 65ac79e18120 ("net: dsa: microchip: add the phylink get_caps")
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>

Applied, thanks!
