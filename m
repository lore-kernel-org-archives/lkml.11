Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 597D3C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 12 May 2022 09:56:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352345AbiELJ4V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 May 2022 05:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352338AbiELJ4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 05:56:16 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC2013879F;
        Thu, 12 May 2022 02:56:14 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id bd25-20020a05600c1f1900b0039485220e16so3914440wmb.0;
        Thu, 12 May 2022 02:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vI+rvT4jTUHk9Zem0CL850oZR0u8HlCjb7Iy9meG1aA=;
        b=lpSgAFrVHDgV+Ou+xzBr6yczkXty0cfBXPNVhifBOx1K1XlM2aoHmrC6HkVUDLQ5ZI
         LOsK5ttHwnnfAVf2UbNhSKRDGx0pgAGhRAulH3RIF4IXyXoRrRUkkj0KuLaFhx3Z0uyO
         eM4g7zPUeD33kOSGvfCxdRRRowYbAqNdlNJkSvjw/Iv0+p0O4sYlUOHQ6A/JBMsPNvPz
         cdYyfzqRam7EHGtogYWasfcT52OZ/Aby5niqbNVNjiRyvHIAMnUv53M4bIoB/oLqxeht
         3HEk9TePNnhNLd4eksRgG/sJOnb0kXALligFZZ51HpBr7q1/hLac3RJTcFgm2yz4lyIt
         AjKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vI+rvT4jTUHk9Zem0CL850oZR0u8HlCjb7Iy9meG1aA=;
        b=OC0EJGGGTR8seMv1U3snLxPg6dHOfR8m3vt98IVCb7a1jRRz6jM4A3QRH+CJE06JPB
         rzlbtRrsTkGeUSMAmCwAug05GbiaE0XfRtEpd1KwRfIEY0K3MF5dxQhF7HU2ygh/+paY
         tu7f4F1XeIMNBlYsGlgKVHPoCdPUA17aVnRJ0VE8WlkhHdnSqcEa2cy5ZaHmzVNoK8Ot
         muw2/dXNKwTDQDBm/WtjHdaZ9wtrPzXI7E+xdz01ffFMZyw74LTrDpFPYmaPmlAotnG0
         s7mdMLqesK4GKrJW49zptHvFNXIA/qa/R3rP3K1xMe5cPBvfnvMfVdJrZPuoeQvNxAkZ
         fQ/w==
X-Gm-Message-State: AOAM531xyZqbHmndfinllPFKVRD9lMEy3NNslvW8sy9V/OB2whEVVkMm
        nJEJ4/3vVfYHEE/SD1adBvI=
X-Google-Smtp-Source: ABdhPJzeOkR8gXtslb2c3OAosJp6H5XjNvatCGsuZGEiFUK0wnEiEhEtz1Qdscrp0cS4adhAzk+RXw==
X-Received: by 2002:a05:600c:1547:b0:394:882a:3b5 with SMTP id f7-20020a05600c154700b00394882a03b5mr9296978wmg.97.1652349373138;
        Thu, 12 May 2022 02:56:13 -0700 (PDT)
Received: from alaa-emad ([197.57.250.210])
        by smtp.gmail.com with ESMTPSA id z15-20020a05600c0a0f00b0039457b94069sm2306913wmp.42.2022.05.12.02.56.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 02:56:12 -0700 (PDT)
From:   Alaa Mohamed <eng.alaamohamedsoliman.am@gmail.com>
To:     netdev@vger.kernel.org
Cc:     outreachy@lists.linux.dev, roopa@nvidia.com, jdenham@redhat.com,
        sbrivio@redhat.com, jesse.brandeburg@intel.com,
        anthony.l.nguyen@intel.com, davem@davemloft.net, kuba@kernel.org,
        pabeni@redhat.com, vladimir.oltean@nxp.com, claudiu.manoil@nxp.com,
        alexandre.belloni@bootlin.com, shshaikh@marvell.com,
        manishc@marvell.com, razor@blackwall.org,
        intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org,
        UNGLinuxDriver@microchip.com, GR-Linux-NIC-Dev@marvell.com,
        bridge@lists.linux-foundation.org,
        eng.alaamohamedsoliman.am@gmail.com
Subject: [PATCH net-next v7 0/2] propagate extack to vxlan_fdb_delete
Date:   Thu, 12 May 2022 11:55:52 +0200
Message-Id: <cover.1652348961.git.eng.alaamohamedsoliman.am@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to propagate extack to vxlan_fdb_delete and vxlan_fdb_parse,
add extack to .ndo_fdb_del and edit all fdb del handelers.

Alaa Mohamed (2):
  rtnetlink: add extack support in fdb del handlers
  net: vxlan: Add extack support to vxlan_fdb_delete

 drivers/net/ethernet/intel/ice/ice_main.c     |  3 +-
 drivers/net/ethernet/mscc/ocelot_net.c        |  3 +-
 .../net/ethernet/qlogic/qlcnic/qlcnic_main.c  |  3 +-
 drivers/net/macvlan.c                         |  3 +-
 drivers/net/vxlan/vxlan_core.c                | 41 +++++++++++++------
 include/linux/netdevice.h                     |  2 +-
 net/bridge/br_fdb.c                           |  3 +-
 net/bridge/br_private.h                       |  3 +-
 net/core/rtnetlink.c                          |  4 +-
 9 files changed, 44 insertions(+), 21 deletions(-)

-- 
2.36.1

