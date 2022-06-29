Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE21CC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jun 2022 11:39:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233161AbiF2LjB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jun 2022 07:39:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233036AbiF2Li4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 07:38:56 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 530733DA61
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 04:38:54 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 0C1A120011;
        Wed, 29 Jun 2022 11:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1656502733;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ypnc5OCq23W0X4HdDWD6sZsKnrlByxC02RY//sNedVs=;
        b=X1vQlrOvXJDpNI6XfdM+GtyRvgSIw61K7DDPASriWUtJ2tlh8DCi0yDCCDRPiVgvqMF7Af
        aHRYBDzGTECHHLmDfkSP9KYDDZQmAc/y6ZJ7+aslz96wSWRIuMWVLAImxp8H3VsISFEaru
        xH4SVC3t3AfO5PZKjvyYSQtKNf000O5KFXx7LZSCN9NB6ki7bLAxQ8AcyYtgNI2s8tUbaQ
        R2OX7tJXVSQE2F0C09HiHeye9rJr9MK90Hneb4ikCOuR6D0jUfIGJTYeAg656XdPdudTXA
        UglVjRtjfKu0RTr2eLVQMplwDI0izDojom/f0EGyQXAqsP0Kj+SP6jeOqQ7w5A==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Christian Marangi <ansuelsmth@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jens Axboe <axboe@kernel.dk>, Stephen Boyd <sboyd@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?utf-8?b?77+9ZWNraQ==?= <rafal@milecki.pl>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/3] dt-bindings: mtd: partitions: support label/name only partition
Date:   Wed, 29 Jun 2022 13:38:51 +0200
Message-Id: <20220629113851.283725-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220622010628.30414-2-ansuelsmth@gmail.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'118f3fbe517f49e17877f34fd677f7374970d92e'
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-06-22 at 01:06:26 UTC, Christian Marangi wrote:
> Document new partition nodes that declare only the label/name instead
> of the reg used to provide an OF node for partition registred at runtime
> by parsers. This is required for nvmem system to declare and detect
> nvmem-cells.
> 
> With these special partitions, the reg / offset is not required and a
> 'partition-' prefix is needed.
> The node name with the 'partition-' prefix stripped, is used to match
> the partition allocated by the parser at runtime and the parser will
> provide reg and offset of the mtd.
> If the partition to match contains invalid char for a node name, the
> label binding can be used to declare the partition name.
> 
> NVMEM will use the data from the parser and provide the NVMEM cells
> declared in the DTS, "connecting" the dynamic partition with a
> static declaration of cells in them.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next, thanks.

Miquel
