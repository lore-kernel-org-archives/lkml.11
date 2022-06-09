Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD48BC433EF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jun 2022 22:41:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237552AbiFIWlH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jun 2022 18:41:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232459AbiFIWlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 18:41:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE1F64666B;
        Thu,  9 Jun 2022 15:41:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 487F461EC3;
        Thu,  9 Jun 2022 22:41:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 881C2C34114;
        Thu,  9 Jun 2022 22:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654814461;
        bh=+GPNoZr6VVDd/MqYRrBAuSI4eZJSHyGHUkBPHzv2TqI=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=crkOhECm64GtihRRAE89kXy5X1oLoGFsHSol51xD7WmC83hRc2G7pixErH0MNbnNy
         tDIoBqG34D1uPPDJ9Ysqis+1OZjrL3RKNetGW5VljtXDJ4/f2IqCW21+KvJX3BEDd3
         7YkEfAoM3vbHEC0ty/Lp8wrY+NgHODkM74hwcVxRpi1FUPfuN6SNhKJk3PtSnBNNve
         eIS5/0h1e8qzjXaCPjGPI9AVt/EE+0LwP7YYG4NVXqi6yYXVsnP0GI/jcXpxhrtPCS
         QJtQCR5CXEXHLdKHRNhEvd1ePaGT2b64jBmHl+4LPbrP0s/922Po9oxjON7FjktxMw
         BYUJf83m1cEjA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220531051742.43273-1-samuel@sholland.org>
References: <20220531051742.43273-1-samuel@sholland.org>
Subject: Re: [PATCH 1/2] clk: fixed: Remove Allwinner A10 special-case logic
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Jernej Skrabec <jernej.skrabec@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <mripard@kernel.org>,
        Samuel Holland <samuel@sholland.org>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Michael Turquette <mturquette@baylibre.com>,
        Samuel Holland <samuel@sholland.org>
Date:   Thu, 09 Jun 2022 15:40:59 -0700
User-Agent: alot/0.10
Message-Id: <20220609224101.881C2C34114@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Samuel Holland (2022-05-30 22:17:41)
> This compatible is part of the legacy sunxi clock support, and has not
> been used since commit 6b48644b1d29 ("ARM: gr8: Convert to CCU") in
> October 2016. Since supporting this compatible adds some overhead to
> generic clock code, let's clean it up.
>=20
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---

Applied to clk-next
