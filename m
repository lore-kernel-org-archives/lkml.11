Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6537C433EF
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Mar 2022 03:28:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbiCLD3r (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Mar 2022 22:29:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiCLD3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 22:29:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAFEA21D09B;
        Fri, 11 Mar 2022 19:28:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 735C2B82462;
        Sat, 12 Mar 2022 03:28:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 115FCC340EE;
        Sat, 12 Mar 2022 03:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647055718;
        bh=eAepGPFthZRnMOifGDED89YfZDFoEDTTbOpsq50itSI=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=VuZhxBO8Ndx/XnvM19LvOH793QJlaTm+8ejDG3t/82zKLg+/2ChlWXL+kNqWmXgAr
         gBfDVBszP3wi7539eRl9OaRMJF+JegZqxsBCv9iRM299s69RbLdW4Wh+J25V6ZZodi
         vFU1Qip68y03SjdP4eEBEFDI3lA6lyKcgmz4gYCekN1e7V2FrTw6eVEJsdfE7dHFgS
         Lj6jx5eePcDgB4xbYeLGTEGA+jiee9U0U3tOVLIOyKYTxHFOG5FexW75YONMVBKr39
         JDWjpg0AYJBqzKeyB4SWrb6djVejKTAkOqw7ure2ntD/uyObpIltWr+a0xygejLWZ3
         ovV6K0OkQBCcg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <eb102eae05e5667b9bd342a0c387f7f262d24bda.1645716471.git.geert+renesas@glider.be>
References: <eb102eae05e5667b9bd342a0c387f7f262d24bda.1645716471.git.geert+renesas@glider.be>
Subject: Re: [PATCH] clk: COMMON_CLK_LAN966X should depend on SOC_LAN966
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>
Date:   Fri, 11 Mar 2022 19:28:36 -0800
User-Agent: alot/0.10
Message-Id: <20220312032838.115FCC340EE@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Geert Uytterhoeven (2022-02-24 07:29:17)
> The LAN966x Generic Clock Controller is only present on Microchip
> LAN966x SoCs.  Hence add a dependency on SOC_LAN966, to prevent asking
> the user about this driver when configuring a kernel without LAN966x SoC
> support.
>=20
> Fixes: 54104ee023333e3b ("clk: lan966x: Add lan966x SoC clock driver")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---

Applied to clk-next
