Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2B0DC433EF
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Apr 2022 11:46:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbiDFLsd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Apr 2022 07:48:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbiDFLrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 07:47:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5ADD9596CB3
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 01:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649234149;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=AKDoheaBR9lQHEGAq6e93WppQz6rpnOwI9HzRDlIjX0=;
        b=AF4GLzb05mGv0ypfz2JGbzFy25JwR/93RqDmtasMREXT9U3T5tyt47ejJLntC8ITKk1Mjk
        WFdwvWVHF16+NftVT2lj4qJFDgaXtOa05e4Su/zg2B0cbCLVVGbIYZC/xfXrh9qxxVpCe1
        T77AkaZXAXL+DP6ZGLndaozpU1iUR9w=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-591-Jl9pZcUwP5eIAeitqjb2Zg-1; Wed, 06 Apr 2022 04:35:46 -0400
X-MC-Unique: Jl9pZcUwP5eIAeitqjb2Zg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C4A0B2800940;
        Wed,  6 Apr 2022 08:35:45 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-58.pek2.redhat.com [10.72.12.58])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 99C591121319;
        Wed,  6 Apr 2022 08:35:42 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, jasowang@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, maz@kernel.org, tglx@linutronix.de,
        peterz@infradead.org, sgarzare@redhat.com
Subject: [PATCH V2 0/5] rework on the IRQ hardening of virtio
Date:   Wed,  6 Apr 2022 16:35:33 +0800
Message-Id: <20220406083538.16274-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All:

This is a rework on the IRQ hardening for virtio which is done
previously by the following commits are reverted:

9e35276a5344 ("virtio_pci: harden MSI-X interrupts")
080cd7c3ac87 ("virtio-pci: harden INTX interrupts")

The reason is that it depends on the IRQF_NO_AUTOEN which may conflict
with the assumption of the affinity managed IRQ that is used by some
virtio drivers. And what's more, it is only done for virtio-pci but
not other transports.

In this rework, I try to implement a general virtio solution which
borrows the idea of the INTX hardening by introducing a boolean for
virtqueue callback enabling and toggle it in virtio_device_ready()
and virtio_reset_device(). Then vring_interrupt() can simply check and
return early if the driver is not ready.

Please review.

Changes since v1:

- Use transport specific irq synchronization method when possible
- Drop the module parameter and enable the hardening unconditonally
- Tweak the barrier/ordering facilities used in the code
- Reanme irq_soft_enabled to driver_ready
- Avoid unnecssary IRQ synchornization (e.g during boot)

Jason Wang (4):
  virtio: use virtio_reset_device() when possible
  virtio: introduce config op to synchronize vring callbacks
  virtio-pci: implement synchronize_vqs()
  virtio: harden vring IRQ

Stefano Garzarella (1):
  virtio: use virtio_device_ready() in virtio_device_restore()

 drivers/virtio/virtio.c            | 20 ++++++++++++++++----
 drivers/virtio/virtio_pci_common.c | 14 ++++++++++++++
 drivers/virtio/virtio_pci_common.h |  2 ++
 drivers/virtio/virtio_pci_legacy.c |  1 +
 drivers/virtio/virtio_pci_modern.c |  2 ++
 drivers/virtio/virtio_ring.c       |  9 ++++++++-
 include/linux/virtio.h             |  2 ++
 include/linux/virtio_config.h      | 24 ++++++++++++++++++++++++
 8 files changed, 69 insertions(+), 5 deletions(-)

-- 
2.25.1

