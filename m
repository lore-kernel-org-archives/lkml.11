Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0136C19F2C
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Aug 2022 05:27:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232140AbiHPF1m (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Aug 2022 01:27:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231660AbiHPF1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 01:27:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CA91D10DCF9
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 15:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660600827;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=pPu4b41HwKIyHkmNffFRKvMIGXhZxqL1ITgc3xx1I1w=;
        b=HuzlL7xvWrZcdK2cW9c7PadGZbVdc7EqeBLJVJ5D46wp+UwslHC9cTSHUZSGCulZ3+/YWL
        oWK4QaFlN6AQh3/ci7u4hg//qd1g1HXRAI+e3KabG77clh0y64V2Nz9gX6j+op5aqB0xZF
        JK5aDFhezedrH5jcbqDaMCWhE1kj6N0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-548-OoIqtolqMhWtumb3heeBvg-1; Mon, 15 Aug 2022 18:00:26 -0400
X-MC-Unique: OoIqtolqMhWtumb3heeBvg-1
Received: by mail-wm1-f70.google.com with SMTP id i132-20020a1c3b8a000000b003a537064611so4056480wma.4
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 15:00:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=pPu4b41HwKIyHkmNffFRKvMIGXhZxqL1ITgc3xx1I1w=;
        b=trgObMHhvTr1cTDUmItlQUJSSc6xL95Njbw8q+mr8KgcIBCSrHPtnQIbpW4eSt5i0h
         4b+qkJuZPY8S01nYkWumS3WWMVHTSsad/VvEYQ1R7inyrig/ofacgrO2ZgEcWksl/4Ov
         +Nb9RXdvkqYZ1V/Bow72uj1CwkcL6oQcW0Uy/Z/TxNt/NaPdS2NpOaGopl4mIAv4cZkL
         1HeKIAhovN2IGTgBkysIuPUxgjyn07AoxZuPaYij4egtKpPxwAcXzyHYcAmwxweYBvMz
         8udBOPxwrkY7XGYJTuqcD4PsgISc1OsZDPtzL3f9FaaUKDCDOPJ0EDHXD4CARIaHs35w
         SsUg==
X-Gm-Message-State: ACgBeo0anxEVjzhRfTW6yizkRM1T3Grfz3XyQNN3SKQ+XZfTxg1xwoYz
        tzNno6vHzT2gd9jCzFCTZqGOz5xAXRaC168zHYjSlnlb5ukCGWSnbeUFlfC+C88kWci4wpN/6cf
        En49OmvplgoaIk/gqIGGgJe6w4nNDpIoQPTxzvxGVylrNc75V7D+9zjTkSTWuKOAZvDFrxw==
X-Received: by 2002:a05:6000:805:b0:220:748e:82c6 with SMTP id bt5-20020a056000080500b00220748e82c6mr9913880wrb.395.1660600825421;
        Mon, 15 Aug 2022 15:00:25 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5Z3S7UlKgnyuGva/EOPuZ7un81OGKTT1khSSa3kB+Zj8529U4wRbJLuMZFfRZb4ZEBh6IVxg==
X-Received: by 2002:a05:6000:805:b0:220:748e:82c6 with SMTP id bt5-20020a056000080500b00220748e82c6mr9913849wrb.395.1660600825186;
        Mon, 15 Aug 2022 15:00:25 -0700 (PDT)
Received: from redhat.com ([2.55.43.215])
        by smtp.gmail.com with ESMTPSA id q14-20020a05600000ce00b0021ee28ff76esm8271311wrx.38.2022.08.15.15.00.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 15:00:24 -0700 (PDT)
Date:   Mon, 15 Aug 2022 18:00:21 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Greg KH <gregkh@linuxfoundation.org>
Subject: [PATCH v3 0/5] virtio: drop sizing vqs during init
Message-ID: <20220815215938.154999-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reporting after I botched up v2 posting. Sorry about the noise.

Supplying size during init does not work for all transports.
In fact for legacy pci doing that causes a memory
corruption which was reported on Google Cloud.

We might get away with changing size to size_hint so it's
safe to ignore and then fixing legacy to ignore the hint.

But the benefit is unclear in any case, so let's revert for now.
Any new version will have to come with
- documentation of performance gains
- performance testing showing existing workflows
  are not harmed materially. especially ones with
  bursty traffic
- report of testing on legacy devices


Huge shout out to Andres Freund for the effort spent reproducing and
debugging!  Thanks to Guenter Roeck for help with testing!


changes from v2
	drop unrelated patches
changes from v1
	revert the ring size api, it's unused now

Michael S. Tsirkin (5):
  virtio_net: Revert "virtio_net: set the default max ring size by
    find_vqs()"
  virtio: Revert "virtio: add helper virtio_find_vqs_ctx_size()"
  virtio-mmio: Revert "virtio_mmio: support the arg sizes of find_vqs()"
  virtio_pci: Revert "virtio_pci: support the arg sizes of find_vqs()"
  virtio: Revert "virtio: find_vqs() add arg sizes"

 arch/um/drivers/virtio_uml.c             |  2 +-
 drivers/net/virtio_net.c                 | 42 +++---------------------
 drivers/platform/mellanox/mlxbf-tmfifo.c |  1 -
 drivers/remoteproc/remoteproc_virtio.c   |  1 -
 drivers/s390/virtio/virtio_ccw.c         |  1 -
 drivers/virtio/virtio_mmio.c             |  9 ++---
 drivers/virtio/virtio_pci_common.c       | 20 +++++------
 drivers/virtio/virtio_pci_common.h       |  3 +-
 drivers/virtio/virtio_pci_legacy.c       |  6 +---
 drivers/virtio/virtio_pci_modern.c       | 17 +++-------
 drivers/virtio/virtio_vdpa.c             |  1 -
 include/linux/virtio_config.h            | 26 +++------------
 12 files changed, 28 insertions(+), 101 deletions(-)

-- 
MST

