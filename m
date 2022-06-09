Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 953CEC433EF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jun 2022 12:42:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236908AbiFIMm4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jun 2022 08:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343526AbiFIMmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 08:42:53 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A8CD2F662
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 05:42:52 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 9F913FF80D;
        Thu,  9 Jun 2022 12:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1654778570;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=41nAwBo/IlfT2O9XMs4CbFOgqOjq0QItWoiDOln6yns=;
        b=YRAUdyRimoPp6Iz6OTTJGZz2A9L8gpCpe6LUFOvX9H5yzukblVVvotteqLPq3CFUE5SJ89
        B5uUJHQYKVdGCxxz2e9SqiMVNxbz5mac25aeOTLyG9bGvbMag/JVRgPx1Fgk44zcNbcDju
        U98eFXoBFt97Cgv295bUxkfZwSeyywkN5fBKoN6xme1DzIk0VqV1FCILpco7/oIFDqOtgI
        yGXcgr/Afb7ZLmDp7EF/IkPG4vlCZOx4m/S/CwB2vUchgRqsUKadDsNRlRG61NAcbQALfT
        qXz7eWu7Gu9kHSo86jUC418D/9I3nhDkBVfTT/6g7B1pwusPdYmDJobZsIGAdw==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Miaoqian Lin <linmq006@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Corentin Labbe <clabbe@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: partitions: Fix refcount leak in parse_redboot_of
Date:   Thu,  9 Jun 2022 14:42:49 +0200
Message-Id: <20220609124249.133008-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220526110652.64849-1-linmq006@gmail.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'16460c01c0114422a39d6f38b885c9c7a533efcf'
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-05-26 at 11:06:49 UTC, Miaoqian Lin wrote:
> of_get_child_by_name() returns a node pointer with refcount
> incremented, we should use of_node_put() on it when not need anymore.
> Add missing of_node_put() to avoid refcount leak.
> 
> Fixes: 237960880960 ("mtd: partitions: redboot: seek fis-index-block in the right node")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next, thanks.

Miquel
