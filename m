Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E394C32772
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Aug 2022 11:55:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358726AbiHWLy6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Aug 2022 07:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359087AbiHWLvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 07:51:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 694F1D3EF3;
        Tue, 23 Aug 2022 02:32:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 332D7B81C97;
        Tue, 23 Aug 2022 09:32:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73F34C433C1;
        Tue, 23 Aug 2022 09:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1661247136;
        bh=wXQAGnKaZny0Q4/nzh2lNS8jJQNaap4Jnt5Roq+fjuo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vNxRFHf0FPGgX/NOJEwIjhnDOQrn3lnCO97uAo4Be4xlSzW+WfKMpBBxlK4RLyq9J
         1ufpY93OE+rRBZvbiV8zEmsiFYOy9VwFgSNLoaNZYIiAgGNcpAvpnf62xvpazp67HG
         0ghY4Qvocpc7jooGz71oJu9A100t37FS73pIauY8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Xin Tan <tanxin.ctf@gmail.com>,
        Xin Xiong <xiongx18@fudan.edu.cn>,
        John Johansen <john.johansen@canonical.com>
Subject: [PATCH 5.4 299/389] apparmor: fix reference count leak in aa_pivotroot()
Date:   Tue, 23 Aug 2022 10:26:17 +0200
Message-Id: <20220823080128.051841893@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220823080115.331990024@linuxfoundation.org>
References: <20220823080115.331990024@linuxfoundation.org>
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
@@ -683,6 +683,7 @@ int aa_pivotroot(struct aa_label *label,
 			aa_put_label(target);
 			goto out;
 		}
+		aa_put_label(target);
 	} else
 		/* already audited error */
 		error = PTR_ERR(target);


