Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8261EC43334
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jun 2022 11:54:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377028AbiFPLyG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jun 2022 07:54:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232528AbiFPLx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 07:53:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29AB75EDCB;
        Thu, 16 Jun 2022 04:53:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BE48CB823A1;
        Thu, 16 Jun 2022 11:53:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AD63C3411B;
        Thu, 16 Jun 2022 11:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1655380432;
        bh=bPwlKPuctXKl5hDacq6yJT82W7UEswS+mvipUboshKs=;
        h=From:To:Cc:Subject:Date:From;
        b=zfxIRv+puPAdq9CEPqRi0OHc+S63hli34i12GbqjGFgKgeqOeTH52Kr70LjpnVLz3
         hSVm0pVJh9vOsRkep8ka/DWkhaKOwsYeosjjgvGlqQQRvOH+hzD8ADF/HyGhmRCJdv
         SlNqkj5aWKsGXZbVfRws65a5ZLGIEMvHB+zcfb6E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.10.123
Date:   Thu, 16 Jun 2022 13:53:45 +0200
Message-Id: <1655380426240143@kroah.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm announcing the release of the 5.10.123 kernel.

All users of the 5.10 kernel series must upgrade.

The updated 5.10.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.10.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/ABI/testing/sysfs-devices-system-cpu              |    1 
 Documentation/admin-guide/hw-vuln/index.rst                     |    1 
 Documentation/admin-guide/hw-vuln/processor_mmio_stale_data.rst |  246 ++++++++++
 Documentation/admin-guide/kernel-parameters.txt                 |   36 +
 Makefile                                                        |    2 
 arch/x86/include/asm/cpufeatures.h                              |    1 
 arch/x86/include/asm/msr-index.h                                |   25 +
 arch/x86/include/asm/nospec-branch.h                            |    2 
 arch/x86/kernel/cpu/bugs.c                                      |  235 ++++++++-
 arch/x86/kernel/cpu/common.c                                    |   52 +-
 arch/x86/kvm/vmx/vmx.c                                          |   72 ++
 arch/x86/kvm/vmx/vmx.h                                          |    2 
 arch/x86/kvm/x86.c                                              |    3 
 drivers/base/cpu.c                                              |    8 
 include/linux/cpu.h                                             |    3 
 tools/arch/x86/include/asm/cpufeatures.h                        |    1 
 tools/arch/x86/include/asm/msr-index.h                          |   25 +
 17 files changed, 675 insertions(+), 40 deletions(-)

Greg Kroah-Hartman (1):
      Linux 5.10.123

Josh Poimboeuf (1):
      x86/speculation/mmio: Print SMT warning

Pawan Gupta (10):
      Documentation: Add documentation for Processor MMIO Stale Data
      x86/speculation/mmio: Enumerate Processor MMIO Stale Data bug
      x86/speculation: Add a common function for MD_CLEAR mitigation update
      x86/speculation/mmio: Add mitigation for Processor MMIO Stale Data
      x86/bugs: Group MDS, TAA & Processor MMIO Stale Data mitigations
      x86/speculation/mmio: Enable CPU Fill buffer clearing on idle
      x86/speculation/mmio: Add sysfs reporting for Processor MMIO Stale Data
      x86/speculation/srbds: Update SRBDS mitigation selection
      x86/speculation/mmio: Reuse SRBDS mitigation for SBDS
      KVM: x86/speculation: Disable Fill buffer clear within guests

