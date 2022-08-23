Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DDF2C32792
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Aug 2022 10:13:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353276AbiHWKNR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Aug 2022 06:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352707AbiHWKGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 06:06:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC59B7D785;
        Tue, 23 Aug 2022 01:52:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 11C7C6123D;
        Tue, 23 Aug 2022 08:52:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0304CC433C1;
        Tue, 23 Aug 2022 08:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1661244747;
        bh=thibkoY1vJoCkfi1Ybho7TQwoOG2KHM67rYyFifPu9s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eVJdRCMUxkr2pQlNaDpMo12CkxYlRGTWnaMkm1hZ4c6prE7HCcDssumSPkRCK3hBD
         y7mjMiUx1DDj0Qv/JRZIGsQDPnFtyIyrgGMdAeCnkiNXkPu2fJhfSrSCFhpd8Upo+Q
         996cxx19Fdds0n3psGAIX8iNEOzuvrQYvGIUzXpo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Xin Tan <tanxin.ctf@gmail.com>,
        Xin Xiong <xiongx18@fudan.edu.cn>,
        John Johansen <john.johansen@canonical.com>
Subject: [PATCH 4.14 184/229] apparmor: fix reference count leak in aa_pivotroot()
Date:   Tue, 23 Aug 2022 10:25:45 +0200
Message-Id: <20220823080100.177336614@linuxfoundation.org>
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

From: Xin Xiong <xiongx18@fudan.edu.cn>

commit 11c3627ec6b56c1525013f336f41b79a983b4d46 upstream.

The aa_pivotroot() function has a reference counting bug in a specific
path. When aa_replace_current_label() returns on success, the function
forgets to decrement the reference count of “target”, which is
increased earlier by build_pivotroot(), causing a reference leak.

Fix it by decreasing the refcount of “target” in that path.

Fixes: 2ea3ffb7782a ("apparmor: add mount mediation")
Co-developed-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
Co-developed-by: Xin Tan <tanxin.ctf@gmail.com>
Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>
Signed-off-by: Xin Xiong <xiongx18@fudan.edu.cn>
Signed-off-by: John Johansen <john.johansen@canonical.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 security/apparmor/mount.c |    1 +
 1 file changed, 1 insertion(+)

--- a/security/apparmor/mount.c
+++ b/security/apparmor/mount.c
@@ -687,6 +687,7 @@ int aa_pivotroot(struct aa_label *label,
 			aa_put_label(target);
 			goto out;
 		}
+		aa_put_label(target);
 	} else
 		/* already audited error */
 		error = PTR_ERR(target);


