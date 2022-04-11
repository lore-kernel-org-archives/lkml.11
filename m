Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F31BC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Apr 2022 09:01:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240269AbiDKJDZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Apr 2022 05:03:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344108AbiDKJDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 05:03:03 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AF7D3EF10;
        Mon, 11 Apr 2022 02:00:48 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 539B3240008;
        Mon, 11 Apr 2022 09:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1649667647;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oi6k+KcXa5PJ23vSkn8qwSpiqFiJay12+EIti3f6WGo=;
        b=ov7SaNgGyVSPe9sLq38ofbcATM/M5UPDeWlYTyYPFweG9PRe3yLIeqCsHD0bKKD6BzJJoZ
        s5EOZ7HIEykce3r7uIIEm7g5zBLl4zvfqDb4ZCwIRYH47SNyMVGtnd2EvE4//2yiYvZqe6
        aCOdJz6a1okTne8Bz9pFyqhEvMtQFussw/ZExdqaQstY7it396XGmVHF7TP8nLJdcK/P4C
        8Iz4UCY2v9rY/UaOyjLAyv5S1OFpXCm1e5KBS1Aga5UeK+5QbI00XymX7HCTn4O0TqrvfI
        dfdDoyNcD7/HwnK4oDD40ICWRJMWG0KIhRSDpROz6AFXjcfFpY5BFyKfgkjO6w==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Roger Quadros <rogerq@kernel.org>, miquel.raynal@bootlin.com,
        robh+dt@kernel.org
Cc:     krzk@kernel.org, richard@nod.at, vigneshr@ti.com, kishon@ti.com,
        nm@ti.com, linux-mtd@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] dt-bindings: mtd: ti,elm: Add support for AM64 ELM
Date:   Mon, 11 Apr 2022 11:00:44 +0200
Message-Id: <20220411090044.11135-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220326080726.30372-3-rogerq@kernel.org>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'05691c0287886806616a1bb0ecbce6ec5e8f43cc'
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2022-03-26 at 08:07:25 UTC, Roger Quadros wrote:
> TI's AM64 SoC has the Error Locator Module. Add compatible and
> related properties to support ELM on AM64 SoC.
> 
> Signed-off-by: Roger Quadros <rogerq@kernel.org>
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
