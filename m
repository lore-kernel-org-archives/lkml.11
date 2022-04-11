Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56FF4C433FE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Apr 2022 01:14:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244231AbiDKBQh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Apr 2022 21:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234340AbiDKBQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 21:16:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AE93B5D;
        Sun, 10 Apr 2022 18:14:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C326960FBD;
        Mon, 11 Apr 2022 01:14:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23366C385A4;
        Mon, 11 Apr 2022 01:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649639662;
        bh=HC3vxkm/3Jsop/jfg4WypoMzrI/j5nLhe4nVJNe90bA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Fe1Rh2Nij7J56owKvkjLV8h1VGQ97S3nWE101/tJPQFYXv3/FeJbtAtgbpmgFIp3J
         m9B/lF3NvmqV8c0mkM31fzXCYohiBNMxzGiK2M8dWmvkF2GkM1XhPWvJqy3CJHFpFE
         o4H6RDlGcJ5xetkWERuMLO7V60sV0eFrKGqhwNzIzJpgbUi7HOaqKnCrCPQ7jNTi5+
         sqnDZx2QP+3gGpGSK0qO5e8GKK3g+MKQ7R5Y6OR7t4NFxF3JfUGlG46Lo2YVD+euH7
         NBQy3wI5LLhe8PibcUMtOA5zloQdgIMkLE3Nf7xP45la9Whk+GDwzPHu5QYfsKwgtg
         6u1QDYWTRsbVA==
Date:   Mon, 11 Apr 2022 09:14:15 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] ARM: dts: imx8mm-venice-gw{71xx,72xx,73xx}: fix OTG
 controller OC mode
Message-ID: <20220411011415.GA129381@dragon>
References: <20220405193509.8231-1-tharvey@gateworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220405193509.8231-1-tharvey@gateworks.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 05, 2022 at 12:35:09PM -0700, Tim Harvey wrote:
> The GW71xx, GW72xx and GW73xx boards have USB1 routed to a USB OTG
> connectors and USB2 routed to a USB hub.
> 
> The OTG connector has a over-currently protection with an active-low
> pin and the USB1 to HUB connection has no over-current protection (as
> the HUB itself implements this for its downstream ports).
> 
> Add proper dt nodes to specify the over-current pin polarity for USB1
> and disable over-current protection for USB2.
> 
> Fixes: 6f30b27c5ef5 ("arm64: dts: imx8mm: Add Gateworks i.MX 8M Mini Development Kits")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> ---
> v2: add gw71xx as well

Okay, applied v2 instead.
