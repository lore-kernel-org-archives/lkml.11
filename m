Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B0C6C32772
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Aug 2022 09:34:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350719AbiHWJeA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Aug 2022 05:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350625AbiHWJc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 05:32:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7813783BDB;
        Tue, 23 Aug 2022 01:38:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EA55661517;
        Tue, 23 Aug 2022 08:37:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEC77C433B5;
        Tue, 23 Aug 2022 08:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1661243872;
        bh=5F3L1hqSN/7exQ2u/UxDEhO+Ah+rnMqDKqPMrqS7AEE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AS1NiJ0q3hxiyZ6zL0nLPlK2gt+XBOcY1VAp6DK6tUpxMHZqU13zRXdh8xEDDkt0n
         TSIATAzTJTqRNCsQvJu3461MjWAGKz8RqumWQ4xX3Fj7aqmOX1tMTdKNNrWbS1GOwh
         bcreHCio9YrwV/i57XKzl9n//4QH+HChyqvKOfIs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 049/229] ARM: findbit: fix overflowing offset
Date:   Tue, 23 Aug 2022 10:23:30 +0200
Message-Id: <20220823080055.424373126@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220823080053.202747790@linuxfoundation.org>
References: <20220823080053.202747790@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

[ Upstream commit ec85bd369fd2bfaed6f45dd678706429d4f75b48 ]

When offset is larger than the size of the bit array, we should not
attempt to access the array as we can perform an access beyond the
end of the array. Fix this by changing the pre-condition.

Using "cmp r2, r1; bhs ..." covers us for the size == 0 case, since
this will always take the branch when r1 is zero, irrespective of
the value of r2. This means we can fix this bug without adding any
additional code!

Tested-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/lib/findbit.S | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/lib/findbit.S b/arch/arm/lib/findbit.S
index 7848780e8834..20fef6c41f6f 100644
--- a/arch/arm/lib/findbit.S
+++ b/arch/arm/lib/findbit.S
@@ -43,8 +43,8 @@ ENDPROC(_find_first_zero_bit_le)
  * Prototype: int find_next_zero_bit(void *addr, unsigned int maxbit, int offset)
  */
 ENTRY(_find_next_zero_bit_le)
-		teq	r1, #0
-		beq	3b
+		cmp	r2, r1
+		bhs	3b
 		ands	ip, r2, #7
 		beq	1b			@ If new byte, goto old routine
  ARM(		ldrb	r3, [r0, r2, lsr #3]	)
@@ -84,8 +84,8 @@ ENDPROC(_find_first_bit_le)
  * Prototype: int find_next_zero_bit(void *addr, unsigned int maxbit, int offset)
  */
 ENTRY(_find_next_bit_le)
-		teq	r1, #0
-		beq	3b
+		cmp	r2, r1
+		bhs	3b
 		ands	ip, r2, #7
 		beq	1b			@ If new byte, goto old routine
  ARM(		ldrb	r3, [r0, r2, lsr #3]	)
@@ -118,8 +118,8 @@ ENTRY(_find_first_zero_bit_be)
 ENDPROC(_find_first_zero_bit_be)
 
 ENTRY(_find_next_zero_bit_be)
-		teq	r1, #0
-		beq	3b
+		cmp	r2, r1
+		bhs	3b
 		ands	ip, r2, #7
 		beq	1b			@ If new byte, goto old routine
 		eor	r3, r2, #0x18		@ big endian byte ordering
@@ -152,8 +152,8 @@ ENTRY(_find_first_bit_be)
 ENDPROC(_find_first_bit_be)
 
 ENTRY(_find_next_bit_be)
-		teq	r1, #0
-		beq	3b
+		cmp	r2, r1
+		bhs	3b
 		ands	ip, r2, #7
 		beq	1b			@ If new byte, goto old routine
 		eor	r3, r2, #0x18		@ big endian byte ordering
-- 
2.35.1



