Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACBFCC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jun 2022 01:42:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbiF2Bm0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jun 2022 21:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbiF2BmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 21:42:24 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0A4AD22BEF;
        Tue, 28 Jun 2022 18:42:23 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 6A31E1E80D11;
        Wed, 29 Jun 2022 09:41:13 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id oo2L2J0Khner; Wed, 29 Jun 2022 09:41:10 +0800 (CST)
Received: from localhost.localdomain (unknown [219.141.250.2])
        (Authenticated sender: kunyu@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id D733E1E80CDC;
        Wed, 29 Jun 2022 09:41:10 +0800 (CST)
From:   Li kunyu <kunyu@nfschina.com>
To:     bjorn.andersson@linaro.org
Cc:     agross@kernel.org, kunyu@nfschina.com,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org
Subject: Re: (subset) [PATCH] drivers: the return value statement of the gcc_sm6350_probe function has an extra semicolon
Date:   Wed, 29 Jun 2022 09:41:50 +0800
Message-Id: <20220629014150.4340-1-kunyu@nfschina.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <165644753306.10525.6775278248022275480.b4-ty@linaro.org>
References: <165644753306.10525.6775278248022275480.b4-ty@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


thanks!

