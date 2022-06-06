Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4B38C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jun 2022 17:53:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbiFFRxk (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jun 2022 13:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbiFFRxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 13:53:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E25811451F4
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 10:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654538015;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=sA5FRYdjW46yogT585AFPa7Uprs64JJvNY0R0SXT104=;
        b=R1Z8PtTo5pPkPXpkBysdBoyq95bU3BPDyGsRlXijZ+XWoAxDgfeMz7HJoFwAQt3YK3bnNf
        4DV920MoCG2wLLyz3cWs5ebe5uOOHLFCSfhjFeuvN6hjEDgULC4hRCFGotFdJ9Dw7V/v9O
        0C0ZaWaCjWyAh1Jj8RfZPoAt8w5C4H4=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-94-wX3yXpk8OOSRpbxGlbph8g-1; Mon, 06 Jun 2022 13:53:18 -0400
X-MC-Unique: wX3yXpk8OOSRpbxGlbph8g-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7799E3C60524;
        Mon,  6 Jun 2022 17:53:17 +0000 (UTC)
Received: from [172.30.41.16] (unknown [10.22.35.67])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3F4F7492C3B;
        Mon,  6 Jun 2022 17:53:16 +0000 (UTC)
Subject: [PATCH 0/2] Improve vfio-pci primary GPU assignment behavior
From:   Alex Williamson <alex.williamson@redhat.com>
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch
Cc:     Laszlo Ersek <lersek@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Date:   Mon, 06 Jun 2022 11:53:15 -0600
Message-ID: <165453797543.3592816.6381793341352595461.stgit@omen>
User-Agent: StGit/1.5.dev2+g9ce680a52bd9
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Users attempting to enable vfio PCI device assignment with a GPU will
often block the default PCI driver from the device to avoid conflicts
with the device initialization or release path.  This means that
vfio-pci is sometimes the first PCI driver to bind to the device.  In 
the case of assigning the primary graphics device, low-level console
drivers may still generate resource conflicts.  Users often employ
kernel command line arguments to disable conflicting drivers or
perform unbinding in userspace to avoid this, but the actual solution
is often distribution/kernel config specific based on the included
drivers.

We can instead allow vfio-pci to copy the behavior of
drm_aperture_remove_conflicting_pci_framebuffers() in order to remove
these low-level drivers with conflicting resources.  vfio-pci is not
however a DRM driver, nor does vfio-pci depend on DRM config options,
thus we split out and export the necessary DRM apterture support and
mirror the framebuffer and VGA support.

I'd be happy to pull this series in through the vfio branch if
approved by the DRM maintainers.  Thanks,

Alex

---

Alex Williamson (2):
      drm/aperture: Split conflicting platform driver removal
      vfio/pci: Remove console drivers


 drivers/gpu/drm/drm_aperture.c   | 33 +++++++++++++++++++++++---------
 drivers/vfio/pci/vfio_pci_core.c | 17 ++++++++++++++++
 include/drm/drm_aperture.h       |  2 ++
 3 files changed, 43 insertions(+), 9 deletions(-)

