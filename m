Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4358C32772
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Aug 2022 08:28:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243589AbiHWI2n (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Aug 2022 04:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243328AbiHWIY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 04:24:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 684AB1836B;
        Tue, 23 Aug 2022 01:13:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C9AB361324;
        Tue, 23 Aug 2022 08:13:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C22B0C433C1;
        Tue, 23 Aug 2022 08:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1661242382;
        bh=198MJV5Vfc/FGWCXHEV8mqffz6z2Dlc0B5J2AMGuxB8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tzAox7Vvg2s3HR7LbJhj0OMtp/ITaM78a42faJLH+8RfabHB7twnEz9OzwenVmwWr
         EAbLD1TJpV9PGMEJ9RBOpLSox4HD3G9CXhEt7TYBSCDavcoiS2cIroC95jdOvqTBKx
         tvqZ3i8KSa0ajnl8tNFriTh2VoKf5WaRG9fyZ58Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Laura Abbott <labbott@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Daniel Micay <danielmicay@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 4.9 063/101] nios2: time: Read timer in get_cycles only if initialized
Date:   Tue, 23 Aug 2022 10:03:36 +0200
Message-Id: <20220823080036.986294626@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220823080034.579196046@linuxfoundation.org>
References: <20220823080034.579196046@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guenter Roeck <linux@roeck-us.net>

commit 65d1e3ddeae117f6a224535e10a09145f0f96508 upstream.

Mainline crashes as follows when running nios2 images.

On node 0 totalpages: 65536
free_area_init_node: node 0, pgdat c8408fa0, node_mem_map c8726000
  Normal zone: 512 pages used for memmap
  Normal zone: 0 pages reserved
  Normal zone: 65536 pages, LIFO batch:15
Unable to handle kernel NULL pointer dereference at virtual address 00000000
ea = c8003cb0, ra = c81cbf40, cause = 15
Kernel panic - not syncing: Oops

Problem is seen because get_cycles() is called before the timer it depends
on is initialized. Returning 0 in that situation fixes the problem.

Fixes: 33d72f3822d7 ("init/main.c: extract early boot entropy from the ..")
Cc: Laura Abbott <labbott@redhat.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Daniel Micay <danielmicay@gmail.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/nios2/kernel/time.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/arch/nios2/kernel/time.c
+++ b/arch/nios2/kernel/time.c
@@ -107,7 +107,10 @@ static struct nios2_clocksource nios2_cs
 
 cycles_t get_cycles(void)
 {
-	return nios2_timer_read(&nios2_cs.cs);
+	/* Only read timer if it has been initialized */
+	if (nios2_cs.timer.base)
+		return nios2_timer_read(&nios2_cs.cs);
+	return 0;
 }
 EXPORT_SYMBOL(get_cycles);
 


