Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 251F6C43219
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Apr 2022 21:50:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385266AbiDEVtX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Apr 2022 17:49:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354930AbiDEKQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 06:16:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E367521810;
        Tue,  5 Apr 2022 03:04:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 93F8BB81C83;
        Tue,  5 Apr 2022 10:04:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B7BCC385A2;
        Tue,  5 Apr 2022 10:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649153040;
        bh=GHdBnWH3UX1Xlg0sRoZEr/y66U2ZsPElXuujtK71+AE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i3rF14GhoSeL6bKWctbdAT5E3HXMbO7x0viTfRfgQ2Z/vUjrGq3YqQ/ODDXKhE5cy
         7FgxPUjgYlPN/EnAGITw1/7zQWeUZX19Va9MwSqnGOneA9NPpwODxlCHrbmZUvzxt+
         nf6iG0Gj079TVPkA3Qc4b6cM38KgDVpSkI7+xojY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH 5.10 042/599] Documentation: update stable tree link
Date:   Tue,  5 Apr 2022 09:25:36 +0200
Message-Id: <20220405070300.079386711@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220405070258.802373272@linuxfoundation.org>
References: <20220405070258.802373272@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bagas Sanjaya <bagasdotme@gmail.com>

commit 555d44932c67e617d89bc13c81c7efac5b51fcfa upstream.

The link to stable tree is redirected to
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git. Update
accordingly.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
Link: https://lore.kernel.org/r/20220314113329.485372-6-bagasdotme@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/process/stable-kernel-rules.rst |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/Documentation/process/stable-kernel-rules.rst
+++ b/Documentation/process/stable-kernel-rules.rst
@@ -168,7 +168,7 @@ Trees
  - The finalized and tagged releases of all stable kernels can be found
    in separate branches per version at:
 
-	https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git
+	https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
 
  - The release candidate of all stable kernel versions can be found at:
 


