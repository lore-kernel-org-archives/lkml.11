Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AA57C433EF
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Apr 2022 10:05:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233516AbiDGKHw convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Apr 2022 06:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244143AbiDGKHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 06:07:44 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D64B6E6F
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 03:05:43 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1ncP1C-0001nx-Fo; Thu, 07 Apr 2022 12:05:34 +0200
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1ncP17-001aOp-Fq; Thu, 07 Apr 2022 12:05:28 +0200
Received: from pza by lupine with local (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1ncP14-0004Zo-RV; Thu, 07 Apr 2022 12:05:26 +0200
Message-ID: <bf62ecb64b6c2667ee22d0ecbf11c53802caa7a1.camel@pengutronix.de>
Subject: Re: [PATCH] clk: meson: meson8b: fix a memory leak in
 meson8b_clkc_init_common()
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     xkernel.wang@foxmail.com, narmstrong@baylibre.com,
        jbrunet@baylibre.com, mturquette@baylibre.com, sboyd@kernel.org,
        khilman@baylibre.com
Cc:     martin.blumenstingl@googlemail.com,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Thu, 07 Apr 2022 12:05:26 +0200
In-Reply-To: <tencent_FE734C50BC851F2AB5FE1380F833A7E67A0A@qq.com>
References: <tencent_FE734C50BC851F2AB5FE1380F833A7E67A0A@qq.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Do, 2022-04-07 at 17:28 +0800, xkernel.wang@foxmail.com wrote:
> From: Xiaoke Wang <xkernel.wang@foxmail.com>
> 
> `rstc` is allocated by kzalloc() for resetting the controller register,
> however, if reset_controller_register() fails, `rstc` is not properly
> released before returning, which can lead to memory leak.
> Therefore, this patch adds kfree(rstc) on the above error path.
> 
> Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp
