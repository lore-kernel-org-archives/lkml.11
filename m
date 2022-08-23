Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 072FEC32772
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Aug 2022 10:54:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356445AbiHWKyJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Aug 2022 06:54:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355984AbiHWKqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 06:46:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E27274DF6;
        Tue, 23 Aug 2022 02:11:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A1E1460F85;
        Tue, 23 Aug 2022 09:11:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C233C433B5;
        Tue, 23 Aug 2022 09:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1661245894;
        bh=o5kMqKGNeYaD1QjftcGevNh2DTWdrdudlXdleTnx8zM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vh9Iedn+mFjnUK19RPXvM/I//mIuujd0TbWfz+P+yITn39BGtugUjCRPIaChlI7xl
         K3O48o3vxSTS5tIbMLLI2ZiZNdAnW8yMnroQVK04Udip1Cfbqkw0qPREtjkRAhbmbV
         sTpQCjLysEKQvuobtkuKZOO60od+iPlVeuoeH95A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, John Johansen <john.johansen@canonical.com>
Subject: [PATCH 4.19 223/287] apparmor: fix quiet_denied for file rules
Date:   Tue, 23 Aug 2022 10:26:32 +0200
Message-Id: <20220823080108.509062348@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220823080100.268827165@linuxfoundation.org>
References: <20220823080100.268827165@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Johansen <john.johansen@canonical.com>

commit 68ff8540cc9e4ab557065b3f635c1ff4c96e1f1c upstream.

Global quieting of denied AppArmor generated file events is not
handled correctly. Unfortunately the is checking if quieting of all
audit events is set instead of just denied events.

Fixes: 67012e8209df ("AppArmor: basic auditing infrastructure.")
Signed-off-by: John Johansen <john.johansen@canonical.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 security/apparmor/audit.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/security/apparmor/audit.c
+++ b/security/apparmor/audit.c
@@ -143,7 +143,7 @@ int aa_audit(int type, struct aa_profile
 	}
 	if (AUDIT_MODE(profile) == AUDIT_QUIET ||
 	    (type == AUDIT_APPARMOR_DENIED &&
-	     AUDIT_MODE(profile) == AUDIT_QUIET))
+	     AUDIT_MODE(profile) == AUDIT_QUIET_DENIED))
 		return aad(sa)->error;
 
 	if (KILL_MODE(profile) && type == AUDIT_APPARMOR_DENIED)


