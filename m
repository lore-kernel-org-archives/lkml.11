Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA507C433EF
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Feb 2022 16:33:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237080AbiBIQdH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Feb 2022 11:33:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237055AbiBIQdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 11:33:05 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E91AC0613C9
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 08:33:08 -0800 (PST)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id EA05E223E9;
        Wed,  9 Feb 2022 17:33:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1644424386;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=vRgDzyrEmORjs4lHu8d04Tc0LhNc+y24W6ANyXI3vdA=;
        b=RnIBXlYcGHC6A/9nYoCBX5vjaPeIE7KRT9I/YsK8krwYDdnhDQkq61q7FWFKfPrSYwe3r7
        iS/5hRjpmKmACrDknRZcPCvid2xs/KOT02HMuQzcUmi7xY5Bu2/R7xTNTnOkTjIWXIedv4
        XoPjI6j4L5JqjdTYOR0sf91pGMnvpaU=
From:   Michael Walle <michael@walle.cc>
To:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Li Yang <leoyang.li@nxp.com>, Ulf Hansson <ulf.hansson@linaro.org>,
        Sudeep Holla <Sudeep.Holla@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH v2 0/7] soc: fsl: guts: cleanups and serial_number support
Date:   Wed,  9 Feb 2022 17:32:35 +0100
Message-Id: <20220209163242.430265-1-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series converts the guts driver from a platform driver to just an
core_initcall. The driver itself cannot (or rather should never) be
unloaded because others depends on detecting the current SoC revision
to apply chip errata. Other SoC drivers do it the same way. Overall I
got rid of all the global static variables.

The last patch finally adds unique id support to the guts driver. But
because the binding [1] for the security fuse processor is still pending,
it is marked as RFC.

[1] https://lore.kernel.org/linux-devicetree/20220127163728.3650648-2-michael@walle.cc/

changes since v1:
 - call kfree() in error case, thanks Dan
 - add missing of_node_put(np), thanks Dan

Michael Walle (7):
  soc: fsl: guts: machine variable might be unset
  soc: fsl: guts: remove module_exit() and fsl_guts_remove()
  soc: fsl: guts: embed fsl_guts_get_svr() in probe()
  soc: fsl: guts: allocate soc_dev_attr on the heap
  soc: fsl: guts: use of_root instead of own reference
  soc: fsl: guts: drop platform driver
  soc: fsl: guts: add serial_number support

 drivers/soc/fsl/guts.c | 219 ++++++++++++++++++++++-------------------
 1 file changed, 118 insertions(+), 101 deletions(-)

-- 
2.30.2

