Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40679C35273
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Apr 2022 21:57:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388833AbiDEV5W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Apr 2022 17:57:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354908AbiDEKQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 06:16:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64D597662;
        Tue,  5 Apr 2022 03:03:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1F22AB81C83;
        Tue,  5 Apr 2022 10:03:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 678D6C385A2;
        Tue,  5 Apr 2022 10:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649153026;
        bh=nYF/5LlqJxR+dXjtyHU6EiTxJe3DQ65PTODezaKI2RE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q+8Kof/KYd1qeCYVqt/KMXszZ86uqZRyqXIOcNNTsw5huzo0uuOYXbiaSHjFBVlja
         HMlJ7K4i5MfThCAdCCIbuVEG2VX7xcyTt7aONt2Ajas3YAZfdf9XPLMf2lhEPDS2Sm
         7nWi+q3m3b+6XnUc/p/5zIcNjMvO6rqYYc/9ehYc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH 5.10 038/599] clk: uniphier: Fix fixed-rate initialization
Date:   Tue,  5 Apr 2022 09:25:32 +0200
Message-Id: <20220405070259.958975419@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220405070258.802373272@linuxfoundation.org>
References: <20220405070258.802373272@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>

commit ca85a66710a8a1f6b0719397225c3e9ee0abb692 upstream.

Fixed-rate clocks in UniPhier don't have any parent clocks, however,
initial data "init.flags" isn't initialized, so it might be determined
that there is a parent clock for fixed-rate clock.

This sets init.flags to zero as initialization.

Cc: <stable@vger.kernel.org>
Fixes: 734d82f4a678 ("clk: uniphier: add core support code for UniPhier clock driver")
Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Link: https://lore.kernel.org/r/1646808918-30899-1-git-send-email-hayashi.kunihiko@socionext.com
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/clk/uniphier/clk-uniphier-fixed-rate.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/clk/uniphier/clk-uniphier-fixed-rate.c
+++ b/drivers/clk/uniphier/clk-uniphier-fixed-rate.c
@@ -24,6 +24,7 @@ struct clk_hw *uniphier_clk_register_fix
 
 	init.name = name;
 	init.ops = &clk_fixed_rate_ops;
+	init.flags = 0;
 	init.parent_names = NULL;
 	init.num_parents = 0;
 


