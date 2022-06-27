Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80A5CC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jun 2022 11:29:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235314AbiF0L3g (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jun 2022 07:29:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235285AbiF0L24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 07:28:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 905B09FC3;
        Mon, 27 Jun 2022 04:27:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2CBA6B81123;
        Mon, 27 Jun 2022 11:27:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72A28C3411D;
        Mon, 27 Jun 2022 11:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1656329257;
        bh=JyU7QdtanPItAWLFTxHBGyzoqPm3H0wGH2eLtiLYtEM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qdIhC73Z8kKgUZRC89dLGiJjd9y02mXi8AntRQjErOHwwc9XIxQkoJMM/9eHX9YHe
         nQXLRZXqdA92TClGeChIQ/rnf+zY03Og1SJJ3E0QGpnEySWOCmcbRzyIJFjIxnT/Mj
         RqFVdD1TmnRPvfnSo1xxmn6LJT8hTuG1se9TK+5Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Liang He <windhl@126.com>,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 5.10 085/102] xtensa: xtfpga: Fix refcount leak bug in setup
Date:   Mon, 27 Jun 2022 13:21:36 +0200
Message-Id: <20220627111935.987878420@linuxfoundation.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220627111933.455024953@linuxfoundation.org>
References: <20220627111933.455024953@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liang He <windhl@126.com>

commit 173940b3ae40114d4179c251a98ee039dc9cd5b3 upstream.

In machine_setup(), of_find_compatible_node() will return a node
pointer with refcount incremented. We should use of_node_put() when
it is not used anymore.

Cc: stable@vger.kernel.org
Signed-off-by: Liang He <windhl@126.com>
Message-Id: <20220617115323.4046905-1-windhl@126.com>
Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/xtensa/platforms/xtfpga/setup.c |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/xtensa/platforms/xtfpga/setup.c
+++ b/arch/xtensa/platforms/xtfpga/setup.c
@@ -133,6 +133,7 @@ static int __init machine_setup(void)
 
 	if ((eth = of_find_compatible_node(eth, NULL, "opencores,ethoc")))
 		update_local_mac(eth);
+	of_node_put(eth);
 	return 0;
 }
 arch_initcall(machine_setup);


