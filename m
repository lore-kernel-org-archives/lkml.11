Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06886C32771
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Aug 2022 19:47:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351623AbiHSTri (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Aug 2022 15:47:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231806AbiHSTrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 15:47:36 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DE331136A5;
        Fri, 19 Aug 2022 12:47:35 -0700 (PDT)
Received: from stanislav-HLY-WX9XX.. (unknown [46.172.22.155])
        by mail.ispras.ru (Postfix) with ESMTPSA id 6C78640737D3;
        Fri, 19 Aug 2022 19:47:32 +0000 (UTC)
From:   Stanislav Goriainov <goriainov@ispras.ru>
To:     stable@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Stanislav Goriainov <goriainov@ispras.ru>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Xiaolong Huang <butterflyhuangxx@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org
Subject: [PATCH 5.10 0/1] qrtr: Convert qrtr_ports from IDR to XArray
Date:   Fri, 19 Aug 2022 22:47:26 +0300
Message-Id: <20220819194727.18911-1-goriainov@ispras.ru>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Syzkaller reports using smp_processor_id() in preemptible code at
radix_tree_node_alloc() in 5.10 stable releases. The problem has 
been fixed by the following patch which can be cleanly applied to 
the 5.10 branch.

Found by Linux Verification Center (linuxtesting.org) with Syzkaller.
