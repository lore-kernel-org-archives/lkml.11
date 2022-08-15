Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D02A1C2BB9D
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Aug 2022 20:16:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346950AbiHOUQf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Aug 2022 16:16:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346465AbiHOUL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 16:11:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A69AC32EC8;
        Mon, 15 Aug 2022 11:57:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 16531B81057;
        Mon, 15 Aug 2022 18:57:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BAB6C43140;
        Mon, 15 Aug 2022 18:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1660589863;
        bh=l0t7eNncgRAPZynlvUSG53rLZJLTg+ipE9Z/Sl0djqU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GgVWqmwnvWqx+vhs+Gb+KnTEjG9g0RqavLa00TQUum8lIhUdo395CBXwhxIXuWj5h
         cHB0u+DgikCulSVLml0rLeV98oSkQz5oF2/WBbkHnZlr5URDEWyKhfklKSSs5I85lo
         WrOP25G989yTPGWksm7wF6JqNFjTSnfuFQWGL0L8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Palmer Dabbelt <palmer@rivosinc.com>
Subject: [PATCH 5.18 0073/1095] wireguard: selftests: set CONFIG_NONPORTABLE on riscv32
Date:   Mon, 15 Aug 2022 19:51:12 +0200
Message-Id: <20220815180432.535168786@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220815180429.240518113@linuxfoundation.org>
References: <20220815180429.240518113@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jason A. Donenfeld <Jason@zx2c4.com>

commit 9019b4f6d9bd88524ecd95420cf9cd4aaed7a125 upstream.

When the CONFIG_PORTABLE/CONFIG_NONPORTABLE switches were added, various
configs were updated, but the wireguard config was forgotten about. This
leads to unbootable test kernels, causing CI fails. Add
CONFIG_NONPORTABLE=y to the wireguard test suite configuration for
riscv32.

Fixes: 44c1e84a38a0 ("RISC-V: Add CONFIG_{NON,}PORTABLE")
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20220809145757.83673-1-Jason@zx2c4.com
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/wireguard/qemu/arch/riscv32.config |    1 +
 1 file changed, 1 insertion(+)

--- a/tools/testing/selftests/wireguard/qemu/arch/riscv32.config
+++ b/tools/testing/selftests/wireguard/qemu/arch/riscv32.config
@@ -1,3 +1,4 @@
+CONFIG_NONPORTABLE=y
 CONFIG_ARCH_RV32I=y
 CONFIG_MMU=y
 CONFIG_FPU=y


