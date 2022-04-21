Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B7A2C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Apr 2022 07:36:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385880AbiDUHiv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Apr 2022 03:38:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385824AbiDUHia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 03:38:30 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E85E13D7B
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 00:35:41 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 19572FF80D;
        Thu, 21 Apr 2022 07:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1650526540;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4jU55ttnkGA9W+XKCmJXdLWIsz4rp3Q076zooBZ1bjY=;
        b=clT3/67CqxmY3hfrSvsstLcHrhFXDFRERcvVI8evEAfUsSJZ8s1NWP6+aHOtTla54sdNTQ
        LflefWK98THbIKM48sAok0bDep2v3FVhzddSYd7TyZ/oaFrNRjSPLx6CKMiOWhE/0fmLEJ
        3xV7WrYt2b8HHT1/HF/Zhnth7qrLn0hZfEVfRGQkmahQBLOiLfWHoh+sNC+ZLFvpKc13m8
        iqgrNydZ9sYUZ2dUaAYVnvnB51GDuUhvYMg5QUEmTmk98d6Lc2+g2AD0UB2LRCtH+XyUG3
        2j7t7bZ4k4RDPLrsMJit86iJ0bSBCYW31eEtNuosfTpB4udW3pGOgJJk65a17g==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Miaoqian Lin <linmq006@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
        Bastian Hecht <hechtb@googlemail.com>,
        Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mtd: rawnand: Fix return value check of wait_for_completion_timeout
Date:   Thu, 21 Apr 2022 09:35:37 +0200
Message-Id: <20220421073537.71822-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220412083435.29254-1-linmq006@gmail.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'084c16ab423a8890121b902b405823bfec5b4365'
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-04-12 at 08:34:31 UTC, Miaoqian Lin wrote:
> wait_for_completion_timeout() returns unsigned long not int.
> It returns 0 if timed out, and positive if completed.
> The check for <= 0 is ambiguous and should be == 0 here
> indicating timeout which is the only error case.
> 
> Fixes: 83738d87e3a0 ("mtd: sh_flctl: Add DMA capabilty")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/fixes, thanks.

Miquel
