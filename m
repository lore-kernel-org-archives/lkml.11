Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BA2AC4332F
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jan 2022 15:39:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234956AbiAWPjo (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jan 2022 10:39:44 -0500
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:56145 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237913AbiAWPjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 10:39:43 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 69B2560003;
        Sun, 23 Jan 2022 15:39:41 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        linux-kernel@vger.kernel.org
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Sascha Hauer <s.hauer@pengutronix.de>, Han Xu <han.xu@nxp.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org
Subject: Re: [PATCH 3/4] mtd: rawnand: gpmi: validate controller clock rate
Date:   Sun, 23 Jan 2022 16:39:41 +0100
Message-Id: <20220123153941.673301-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220118095434.35081-4-dario.binacchi@amarulasolutions.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'15e27d197a7ea69b4643791ca2f8467fdd998359'
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-01-18 at 09:54:33 UTC, Dario Binacchi wrote:
> What to do when the real rate of the gpmi clock is not equal to the
> required one? The solutions proposed in [1] did not lead to a conclusion
> on how to validate the clock rate, so, inspired by the document [2], I
> consider the rate correct only if not lower or equal to the rate of the
> previous edo mode. In fact, in chapter 4.16.2 (NV-DDR) of the document [2],
> it is written that "If the host selects timing mode n, then its clock
> period shall be faster than the clock period of timing mode n-1 and
> slower than or equal to the clock period of timing mode n.". I thought
> that it could therefore also be used in this case, without therefore
> having to define the valid rate ranges empirically.
> 
> For example, suppose that gpmi_nfc_compute_timings() is called to set
> edo mode 5 (100MHz) but the rate returned by clk_round_rate() is 80MHz
> (edo mode 4). In this case gpmi_nfc_compute_timings() will return error,
> and will be called again to set edo mode 4, which this time will be
> successful.
> 
> [1] https://lore.kernel.org/r/20210702065350.209646-5-ebiggers@kernel.org
> [2] http://www.onfi.org/-/media/client/onfi/specs/onfi_3_0_gold.pdf?la=en
> 
> Co-developed-by: Michael Trimarchi <michael@amarulasolutions.com>
> Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> Tested-by: Sascha Hauer <s.hauer@pengutronix.de>
> Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
