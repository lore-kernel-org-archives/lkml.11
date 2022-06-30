Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4C49C43334
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jun 2022 13:53:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235793AbiF3Nxm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jun 2022 09:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235838AbiF3Nwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 09:52:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B2D14579D;
        Thu, 30 Jun 2022 06:49:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 477E26205D;
        Thu, 30 Jun 2022 13:49:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C9C8C3411E;
        Thu, 30 Jun 2022 13:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1656596983;
        bh=tQbpvtEvCBc44itrMEC0A4dvWcUm/1NCxpin/Lzp79o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mxlSejOYVWVZ6MjwtbnPd1fi+PYDn0zzrbS2a2qBJxSmaVX7EdHBTeS0UFvty/XmI
         oMVaw1TfNXLT7dyTSsTTAV8YvyTNFeGfv4AosIf+tgyK9mpuVHAsVNHIKV26gHwHqB
         WM6+gQttotdZFkn6tA38+JOp+9XgBej6IN+WTrl0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Liang He <windhl@126.com>,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 4.14 21/35] xtensa: Fix refcount leak bug in time.c
Date:   Thu, 30 Jun 2022 15:46:32 +0200
Message-Id: <20220630133233.064006826@linuxfoundation.org>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220630133232.433955678@linuxfoundation.org>
References: <20220630133232.433955678@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liang He <windhl@126.com>

commit a0117dc956429f2ede17b323046e1968d1849150 upstream.

In calibrate_ccount(), of_find_compatible_node() will return a node
pointer with refcount incremented. We should use of_node_put() when
it is not used anymore.

Cc: stable@vger.kernel.org
Signed-off-by: Liang He <windhl@126.com>
Message-Id: <20220617124432.4049006-1-windhl@126.com>
Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/xtensa/kernel/time.c |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/xtensa/kernel/time.c
+++ b/arch/xtensa/kernel/time.c
@@ -146,6 +146,7 @@ static void __init calibrate_ccount(void
 	cpu = of_find_compatible_node(NULL, NULL, "cdns,xtensa-cpu");
 	if (cpu) {
 		clk = of_clk_get(cpu, 0);
+		of_node_put(cpu);
 		if (!IS_ERR(clk)) {
 			ccount_freq = clk_get_rate(clk);
 			return;


