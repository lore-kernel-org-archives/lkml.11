Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A091C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Feb 2022 00:53:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236191AbiBYAyK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Feb 2022 19:54:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234370AbiBYAyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 19:54:07 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E13716AA49;
        Thu, 24 Feb 2022 16:53:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EF12A61CEF;
        Fri, 25 Feb 2022 00:53:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55CA5C340E9;
        Fri, 25 Feb 2022 00:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645750416;
        bh=tax7gyujyT6hamv2XDCo/atDi2P1HZEp3rPfnjbbCdE=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=YgLBqBYjepIdalPEmtByKWBteNUDYoZxTTH91SQNLFOkDyz0gGFPRbQ7tL1cRKjRN
         Ugj8t2g6TO/TrTElDEEj5dPdMVXz3/uIXtUDyVKF6UkNRAEE1q4HAqbo1fNJ2IInT0
         GU4y/YxRtX1lpihD6xw0BPtYPqOtt3LMOcPww7WzFdMXMPNdBlH6tRa8bvCMxffXl5
         8+zwcqa3NDFw6qglGhI5+V1Af/fYYxfNYtaESlY50ZzcG41jpooAsNT6h6jzVIMVZm
         +BIEa1VU2iV/vESUGgdk9eyUvpZu0WKtXCVObIcuCiEisQOjOQyQ6JqxrWnJPr0AJn
         lIyGf7ryo8XvA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220219141536.460812-1-horatiu.vultur@microchip.com>
References: <20220219141536.460812-1-horatiu.vultur@microchip.com>
Subject: Re: [PATCH] clk: lan966x: Fix linking error
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     mturquette@baylibre.com, nicolas.ferre@microchip.com,
        kavyasree.kotagiri@microchip.com,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        kernel test robot <lkp@intel.com>
To:     Horatiu Vultur <horatiu.vultur@microchip.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 24 Feb 2022 16:53:34 -0800
User-Agent: alot/0.10
Message-Id: <20220225005336.55CA5C340E9@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Horatiu Vultur (2022-02-19 06:15:36)
> If the config options HAS_IOMEM is not set then the driver fails to link
> with the following error:
> clk-lan966x.c:(.text+0x950): undefined reference to
> `devm_platform_ioremap_resource'
>=20
> Therefor add missing dependencies: HAS_IOMEM and OF.
>=20
> Fixes: 54104ee02333 ("clk: lan966x: Add lan966x SoC clock driver")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> ---

Applied to clk-fixes
