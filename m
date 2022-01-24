Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20A61C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jan 2022 05:20:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239237AbiAXFUq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jan 2022 00:20:46 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:52406 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229505AbiAXFUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 00:20:44 -0500
X-UUID: c5fbe735f43a44eaa7e4570e7da97fac-20220124
X-UUID: c5fbe735f43a44eaa7e4570e7da97fac-20220124
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2101492939; Mon, 24 Jan 2022 13:20:40 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Mon, 24 Jan 2022 13:20:38 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 24 Jan 2022 13:20:38 +0800
From:   Miles Chen <miles.chen@mediatek.com>
To:     <sboyd@kernel.org>
CC:     <chun-jie.chen@mediatek.com>, <ikjn@chromium.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <matthias.bgg@gmail.com>,
        <mturquette@baylibre.com>, <weiyi.lu@mediatek.com>
Subject: Re: [PATCH] clk: mediatek: add unregister logic to mtk_clk_simple_probe error path
Date:   Mon, 24 Jan 2022 13:20:38 +0800
Message-ID: <20220124052038.6242-1-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220117090030.13064-1-miles.chen@mediatek.com>
References: <20220117090030.13064-1-miles.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

> Stephen pointed out that there is no unregister logic in
> mtk_clk_simple_probe() error path [1].
> Fix it by adding unregister logic to mtk_clk_simple_probe().

Chen-Yu's work [1] already addresses this problem. So please ignore
this patch.

[1] https://lore.kernel.org/lkml/20220122091731.283592-1-wenst@chromium.org/

