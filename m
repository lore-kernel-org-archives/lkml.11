Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D00DC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jun 2022 08:06:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233414AbiF0IGZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jun 2022 04:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233412AbiF0IGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 04:06:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35A1A26C9;
        Mon, 27 Jun 2022 01:06:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E9DD4B80FAF;
        Mon, 27 Jun 2022 08:06:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 709B8C341C8;
        Mon, 27 Jun 2022 08:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656317166;
        bh=jRJeG0UgGCqTiw19wratxT9u3xhT6kGN/PnIBlE+ovc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C5gmMqmH0T+Xv1vVuJ3g1uCQp3ePOTYYL1GTJggiYnA+RxVr8UBfrL9JK3aHUb80g
         fyvz8euG44gkVtDLb2DVqtcwOdp49B0FB6MWZ83U4ERy+kXeIj3PH+uhoykBuqYCJR
         yuIDBFFqI64p3RI/vRkUaVvheKWDCbx8ea0buvPSu1MHfe2EKoBpBls/ixNLkfdJ2w
         kYN4apUcecxPFtsNfQitTZrmwROhsOGkUZZ4+zYsloP78czpvGInkmO9fyX6jnx7l+
         3l0dsHHIQKNyqCb/PdP2mMMTUKv1EHtNHGAczVaxqqZB9Ed+bTQ/hRodUZbqPBctWX
         gYZ7heQ0LElNQ==
Date:   Mon, 27 Jun 2022 16:05:59 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Philippe Schenker <dev@pschenker.ch>
Cc:     devicetree@vger.kernel.org,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: imx8m{m,p}-verdin: use IT temperatures
Message-ID: <20220627080559.GI819983@dragon>
References: <20220622164410.457249-1-dev@pschenker.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220622164410.457249-1-dev@pschenker.ch>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2022 at 06:44:10PM +0200, Philippe Schenker wrote:
> From: Philippe Schenker <philippe.schenker@toradex.com>
> 
> Use IT temperature threshold for critical/passive trip point
> on Verdin iMX8M Plus and Mini.
> 
> Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
> Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>

Applied, thanks!
