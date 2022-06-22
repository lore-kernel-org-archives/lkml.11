Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FBD4C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jun 2022 08:29:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352141AbiFVI3f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jun 2022 04:29:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355420AbiFVI24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 04:28:56 -0400
Received: from ssh248.corpemail.net (ssh248.corpemail.net [210.51.61.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3E2F38D8D
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 01:27:49 -0700 (PDT)
Received: from ([60.208.111.195])
        by ssh248.corpemail.net ((D)) with ASMTP (SSL) id RGY00035;
        Wed, 22 Jun 2022 16:27:35 +0800
Received: from localhost.localdomain (10.200.104.82) by
 jtjnmail201610.home.langchao.com (10.100.2.10) with Microsoft SMTP Server id
 15.1.2308.27; Wed, 22 Jun 2022 16:27:36 +0800
From:   Deming Wang <wangdeming@inspur.com>
To:     <mst@redhat.com>, <jasowang@redhat.com>
CC:     <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, Deming Wang <wangdeming@inspur.com>
Subject: [PATCH] virtio_ring: remove unnecessary to_vvq call in poll_packed
Date:   Wed, 22 Jun 2022 04:27:35 -0400
Message-ID: <20220622082735.1780-1-wangdeming@inspur.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.200.104.82]
tUid:   202262216273535ccf849eb8e6e404e80fec5e573b8c6
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It passes '_vq' to virtqueue_use_indirect(), which still calls
to_vvq to get 'vq', let's directly pass 'vq'. It can avoid
unnecessary call of to_vvq in virtqueue_poll_packed.

Signed-off-by: Deming Wang <wangdeming@inspur.com>
---
 drivers/virtio/virtio_ring.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 13a7348cedff..cb6323e0088b 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -1522,9 +1522,8 @@ static unsigned int virtqueue_enable_cb_prepare_packed(struct virtqueue *_vq)
 			VRING_PACKED_EVENT_F_WRAP_CTR);
 }
 
-static bool virtqueue_poll_packed(struct virtqueue *_vq, u16 off_wrap)
+static bool virtqueue_poll_packed(struct vring_virtqueue *vq, u16 off_wrap)
 {
-	struct vring_virtqueue *vq = to_vvq(_vq);
 	bool wrap_counter;
 	u16 used_idx;
 
@@ -2054,7 +2053,7 @@ bool virtqueue_poll(struct virtqueue *_vq, unsigned int last_used_idx)
 		return false;
 
 	virtio_mb(vq->weak_barriers);
-	return vq->packed_ring ? virtqueue_poll_packed(_vq, last_used_idx) :
+	return vq->packed_ring ? virtqueue_poll_packed(vq, last_used_idx) :
 				 virtqueue_poll_split(_vq, last_used_idx);
 }
 EXPORT_SYMBOL_GPL(virtqueue_poll);
-- 
2.27.0

