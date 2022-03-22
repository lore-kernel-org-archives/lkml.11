Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 298A1C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Mar 2022 14:27:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237869AbiCVO2q (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Mar 2022 10:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233818AbiCVO1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 10:27:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 123BC32EF5
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 07:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647959158;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=hqOWJCnDPaU9YtCPm5hIfU7CxXILHB/YTsG839ir6VA=;
        b=h1PJHlDvOqt150P3OCI0vEq+biYlcSe8NFldUhZ/PCXbCS9KWLqXIrk+GyoUZutmzFuoet
        6RwjS3ucktqKQaJa4VLzPp2UTOpz4XcS/M/3dB/VBiZKyMAjhKBG53acM//D7OFUArEx3g
        F+fm7o+GQleuLiIMhaVmPopA+YjxZ0o=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-47-59TpEC-7OW-vBG5qJ6mEjQ-1; Tue, 22 Mar 2022 10:25:57 -0400
X-MC-Unique: 59TpEC-7OW-vBG5qJ6mEjQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3C08985A5BE;
        Tue, 22 Mar 2022 14:25:57 +0000 (UTC)
Received: from ceranb.redhat.com (unknown [10.40.192.65])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 25A1E40CF905;
        Tue, 22 Mar 2022 14:25:55 +0000 (UTC)
From:   Ivan Vecera <ivecera@redhat.com>
To:     netdev@vger.kernel.org
Cc:     poros@redhat.com, mschmidt@redhat.com,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Brett Creeley <brett.creeley@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        intel-wired-lan@lists.osuosl.org (moderated list:INTEL ETHERNET DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net] ice: Clear default forwarding VSI during VSI release
Date:   Tue, 22 Mar 2022 15:25:54 +0100
Message-Id: <20220322142554.3253428-1-ivecera@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VSI is set as default forwarding one when promisc mode is set for
PF interface, when PF is switched to switchdev mode or when VF
driver asks to enable allmulticast or promisc mode for the VF
interface (when vf-true-promisc-support priv flag is off).
The third case is buggy because in that case VSI associated with
VF remains as default one after VF removal.

Reproducer:
1. Create VF
   echo 1 > sys/class/net/ens7f0/device/sriov_numvfs
2. Enable allmulticast or promisc mode on VF
   ip link set ens7f0v0 allmulticast on
   ip link set ens7f0v0 promisc on
3. Delete VF
   echo 0 > sys/class/net/ens7f0/device/sriov_numvfs
4. Try to enable promisc mode on PF
   ip link set ens7f0 promisc on

Although it looks that promisc mode on PF is enabled the opposite
is true because ice_vsi_sync_fltr() responsible for IFF_PROMISC
handling first checks if any other VSI is set as default forwarding
one and if so the function does not do anything. At this point
it is not possible to enable promisc mode on PF without re-probe
device.

To resolve the issue this patch clear default forwarding VSI
during ice_vsi_release() when the VSI to be released is the default
one.

Fixes: 01b5e89aab49 ("ice: Add VF promiscuous support")
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/net/ethernet/intel/ice/ice_lib.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 53256aca27c7..20d755822d43 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -3147,6 +3147,8 @@ int ice_vsi_release(struct ice_vsi *vsi)
 		}
 	}
 
+	if (ice_is_vsi_dflt_vsi(pf->first_sw, vsi))
+		ice_clear_dflt_vsi(pf->first_sw);
 	ice_fltr_remove_all(vsi);
 	ice_rm_vsi_lan_cfg(vsi->port_info, vsi->idx);
 	err = ice_rm_vsi_rdma_cfg(vsi->port_info, vsi->idx);
-- 
2.34.1

