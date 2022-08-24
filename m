Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D5DEC32793
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Aug 2022 00:54:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232560AbiHXAyE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Aug 2022 20:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbiHXAyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 20:54:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4CEC85FF7;
        Tue, 23 Aug 2022 17:54:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 612E46178B;
        Wed, 24 Aug 2022 00:54:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8FBFC433D6;
        Wed, 24 Aug 2022 00:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661302440;
        bh=RrTk1BfDHuYcJZnVddzCtxqhxk8N8F+LC2UoGUuzIEw=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=BnQdLYBR7AZnmnjYm5sfiLVAct1DrClvKdqpuj9DIXBypIwIZEAotOdqD2KAaCbGq
         tdHt5tJTsQvsPoEgVVtOCNEuq5vkJSLRuaa19H/gttvRZHIs5A2JZlo/dytSVOIsUk
         wWhLA7RVUAnoZorkH4O7XYT6fLGwNi/trOo7s5iKzRAM3Redg36HElr8Am7JTi5oD9
         ToV9s6ewP2L01T9+hoCBZDL4EoysPe4SfuZJ64VDt1hvmy50GjSk+Gd7y78+oZx9Mw
         5WALUBSSrwMJXsxXFPaNsSMePVABF5zXPsBnALcBsX7xu3aZRTCHV7/qeOzfOAMTTL
         3M63xTa00a0VA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220630151205.3935560-1-claudiu.beznea@microchip.com>
References: <20220630151205.3935560-1-claudiu.beznea@microchip.com>
Subject: Re: [PATCH 1/2] clk: remove extra empty line
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea@microchip.com>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        mturquette@baylibre.com
Date:   Tue, 23 Aug 2022 17:53:58 -0700
User-Agent: alot/0.10
Message-Id: <20220824005400.B8FBFC433D6@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Claudiu Beznea (2022-06-30 08:12:04)
> Remove extra empty line.
>=20
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---

Applied to clk-next
