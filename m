Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC5EDC433EF
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Feb 2022 16:22:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383070AbiBHQWJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Feb 2022 11:22:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383035AbiBHQWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 11:22:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F4C3C061578
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 08:22:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DFCFFB81BDC
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 16:22:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F27C4C340E9;
        Tue,  8 Feb 2022 16:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644337324;
        bh=VTj/spHCEwi1qioek8/gH/m5ydwg68j7pjPgVChVaOA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bvE9RUBjm+zilzW5At6ta/AZAlWM3CQd1UfGRc+arg3O2o9+vAFJwza1tPnZ6f8kM
         Cc77CqZuZDLkazWMlV1RBEA9DNq1XjoF+2yi8crxPOL5Gknab3VxLGoZ1ttVzsgYQo
         jkHX3LDjEoLyUcB2EEPYgUINfcfurAptoSboJq8+oNUW4Zyl1bgcttNtkEL1YReDDx
         ew5r/xzwVCk9yX9n2VCjEwkxz/qzoiEQAKCB+kB57FlT+Zl947KytK0pKUEwG7o9MN
         UGf7p2Wi1ufQ32ATh2kCXds33BMJCJX5OVcSVsUPVtPHRcffc16dARvHIsRPQXi3kv
         a6r15CvXOD8og==
From:   Will Deacon <will@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>,
        Bhaskara Budiredla <bbudiredla@marvell.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] perf: MARVELL_CN10K_TAD_PMU should depend on ARCH_THUNDER
Date:   Tue,  8 Feb 2022 16:21:52 +0000
Message-Id: <164433205929.3624309.9655939450024180787.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <b4662a2c767d04cca19417e0c845edea2da262ad.1641995941.git.geert+renesas@glider.be>
References: <b4662a2c767d04cca19417e0c845edea2da262ad.1641995941.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jan 2022 15:00:47 +0100, Geert Uytterhoeven wrote:
> The Marvell CN10K Last-Level cache Tag-and-data Units (LLC-TAD)
> performance monitor is only present on Marvell CN10K SoCs.  Hence add a
> dependency on ARCH_THUNDER, to prevent asking the user about this driver
> when configuring a kernel without Cavium Thunder (incl. Marvell CN10K)
> SoC support.
> 
> 
> [...]

Applied to will (for-next/perf), thanks!

[1/1] perf: MARVELL_CN10K_TAD_PMU should depend on ARCH_THUNDER
      https://git.kernel.org/will/c/e564518b0727

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
