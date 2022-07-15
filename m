Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A50EAC43334
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jul 2022 12:19:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232731AbiGOMTr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jul 2022 08:19:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbiGOMTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 08:19:43 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5D45B6173F
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 05:19:42 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.92,273,1650898800"; 
   d="scan'208";a="127988338"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 15 Jul 2022 21:19:41 +0900
Received: from localhost.localdomain (unknown [10.226.92.160])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 81666429692B;
        Fri, 15 Jul 2022 21:19:38 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     michael@walle.cc
Cc:     linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        miquel.raynal@bootlin.com, p.yadav@ti.com,
        quic_c_sbhanu@quicinc.com, richard@nod.at,
        tudor.ambarus@microchip.com, vigneshr@ti.com,
        Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH 1/2] mtd: spi-nor: introduce SNOR_ID3()
Date:   Fri, 15 Jul 2022 13:19:34 +0100
Message-ID: <20220712072304.icesvrfmem5lgr6i@ti.com> (raw)
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220510140232.3519184-2-michael@walle.cc>
References: <20220510140232.3519184-2-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Message-ID: <20220715121934.FXGL61W7k7UD0uoatk8HcwwreBE8RY13_Md1DZXwWn4@z>

On 10/05/22 04:02PM, Michael Walle wrote:
> Up until now, flashes were defined by specifying the JEDEC ID, the
> sector size and the number of sectors. This can be read by parsing the
> SFDP, we don't have to specify it. Thus provide a new macro SNOR_ID3()
> which just takes the JEDEC ID and implicitly set .parse_sfdp = true. All
> new flashes which have SFDP should use this macro.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>

Tested the macro with Renesas AT25QL128A serial nor flash. So,

Tested-by: Biju Das <biju.das.jz@bp.renesas.com>
