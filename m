Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C324C43334
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Jul 2022 02:28:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbiGIC2D (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Jul 2022 22:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiGIC2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 22:28:01 -0400
Received: from smtp236.sjtu.edu.cn (smtp236.sjtu.edu.cn [202.120.2.236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F21879EE8
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 19:28:00 -0700 (PDT)
Received: from proxy02.sjtu.edu.cn (smtp188.sjtu.edu.cn [202.120.2.188])
        by smtp236.sjtu.edu.cn (Postfix) with ESMTPS id E682F1008B388;
        Sat,  9 Jul 2022 10:27:56 +0800 (CST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by proxy02.sjtu.edu.cn (Postfix) with ESMTP id 3A5972009BEB0;
        Sat,  9 Jul 2022 10:27:55 +0800 (CST)
X-Virus-Scanned: amavisd-new at 
Received: from proxy02.sjtu.edu.cn ([127.0.0.1])
        by localhost (proxy02.sjtu.edu.cn [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ZHSYgIQx0MTq; Sat,  9 Jul 2022 10:27:54 +0800 (CST)
Received: from localhost.localdomain (unknown [202.120.40.82])
        (Authenticated sender: qtxuning1999@sjtu.edu.cn)
        by proxy02.sjtu.edu.cn (Postfix) with ESMTPSA id 0ADEF2009BEA0;
        Sat,  9 Jul 2022 10:27:45 +0800 (CST)
From:   Guo Zhi <qtxuning1999@sjtu.edu.cn>
To:     jasowang@redhat.com, mst@redhat.com
Cc:     eperezma@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, sgarzare@redhat.com,
        Guo Zhi <qtxuning1999@sjtu.edu.cn>
Subject: [PATCH v3 0/4] virtio/virtio_test
Date:   Sat,  9 Jul 2022 10:27:41 +0800
Message-Id: <20220709022745.21020-1-qtxuning1999@sjtu.edu.cn>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Original virtio_test only use add one descriptor for each io event, thus code of descriptor chain and indirection have not been tested(one descriptor will not use indirect feature even indirect feature has been specified). In fact it would have not been possible for vhost_test to access to the indirect descriptor table, because it's impossible for virtio_ring.c to allocate it.

This series using descriptor chain and enable indirection feature. And through gcov we find the code coverage has been improved(not high for virtio_ring.c because virtio_test only test split virtqueue):

+------------+-------------+-------------+
|            |virtio_test.c|virtio_ring.c|
+------------+-------------+-------------+
| original   |   72.32%    |   24.71%    |
+------------+-------------+-------------+
| current    |    75%      |   28.05%    |
+------------+-------------+-------------+

Guo Zhi (4):
  virtio_test: kick vhost for a batch of descriptors
  virtio_test: use random length scatterlists to test descriptor chain
  virtio_test: enable indirection feature
  virtio_test: pregenerate random numbers

 tools/virtio/virtio_test.c | 85 ++++++++++++++++++++++++++++++--------
 1 file changed, 68 insertions(+), 17 deletions(-)

-- 
2.17.1

