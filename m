Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACD00C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Apr 2022 16:25:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237730AbiDFQ1N (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Apr 2022 12:27:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237710AbiDFQ06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 12:26:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 362261B309A;
        Tue,  5 Apr 2022 19:16:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B59756153E;
        Wed,  6 Apr 2022 02:16:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC5FCC385A1;
        Wed,  6 Apr 2022 02:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649211407;
        bh=cRoUNyugEoBJs/eqNGiLRSxa0CDhLNVexQ2ZkFWEMbE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XdI2Nn+AP3oMkqS2k81buZc04LsU81yD3okAtvgRCXuhc9BSVMQMiw4fMhLD9seEM
         fgDA1tx2FQ8AY5Q/Bp12oNBGBpySDFYE9VZ/IgLH3F3ofWzzg1bRfd/CVHG+QpwcSV
         J4iV2AjZPEUfSl/BR59Gf7uRctBZ5s73/AJHf65BnfkurHdt0c7A1ccKyHkgWTzG6S
         z0dbNfNthRmgTGGgKy46kCUmT+QZ/3ViQ29Ba1Rr6hz63Ck4KLRAt6ARDARQQmDnke
         vGMyEcgKYimTxf56/GiQhs1jD1aT0UCog1+tXeYMPydA1qW2GHXzsNbB91p2cZVR8w
         auqj4n6pLI1Lw==
Date:   Wed, 6 Apr 2022 10:16:39 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Robin van der Gracht <robin@protonic.nl>,
        devicetree@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v1 7/8] ARM: dts: imx6dl-victgo: The TGO uses a
 lg,lb070wv8 compatible 7" display
Message-ID: <20220406021639.GL129381@dragon>
References: <20220221095312.3692669-1-o.rempel@pengutronix.de>
 <20220221095312.3692669-7-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220221095312.3692669-7-o.rempel@pengutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 21, 2022 at 10:53:11AM +0100, Oleksij Rempel wrote:
> From: Robin van der Gracht <robin@protonic.nl>
> 
> This series of devices is using lg,lb070wv8 instead of kyo,tcg121xglp.
> 
> Signed-off-by: Robin van der Gracht <robin@protonic.nl>
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

Applied, thanks!
