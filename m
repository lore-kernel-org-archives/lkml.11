Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B536DC32774
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Aug 2022 08:13:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242300AbiHWINy (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Aug 2022 04:13:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242032AbiHWIK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 04:10:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BAF94D26D;
        Tue, 23 Aug 2022 01:07:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 34378611A8;
        Tue, 23 Aug 2022 08:07:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40B4BC433D7;
        Tue, 23 Aug 2022 08:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1661242033;
        bh=QAUfSsC9KYdgVc/yLgZVFvSM3OJFgxmGWfCvmlPxxBY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KUw3GsWsoLfmVns6TXXuDxT006pBrbph3KxF4dPQRSyyYhAZ3UyNdHEm6cIyQ7wll
         x8G3Ojr6pH59LZgXBHn4tHOXXJQjLim37lQAhvRhv08LSzTHdlJa4w8CoY9QCPNedH
         dH8rwObTT4qNzSm4TB+zOqZA6AQD/YWsEMbUOZ8I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 4.9 009/101] ion: Make user_ion_handle_put_nolock() a void function
Date:   Tue, 23 Aug 2022 10:02:42 +0200
Message-Id: <20220823080034.945293377@linuxfoundation.org>
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

From: Nathan Chancellor <nathan@kernel.org>

Clang warns:

  drivers/staging/android/ion/ion-ioctl.c:71:6: warning: variable 'ret' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
          if (--handle->user_ref_count == 0)
              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  drivers/staging/android/ion/ion-ioctl.c:74:9: note: uninitialized use occurs here
          return ret;
                 ^~~
  drivers/staging/android/ion/ion-ioctl.c:71:2: note: remove the 'if' if its condition is always true
          if (--handle->user_ref_count == 0)
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  drivers/staging/android/ion/ion-ioctl.c:69:9: note: initialize the variable 'ret' to silence this warning
          int ret;
                 ^
                  = 0
  1 warning generated.

The return value of user_ion_handle_put_nolock() is not checked in its
one call site in user_ion_free_nolock() so just make
user_ion_handle_put_nolock() return void to remove the warning.

Fixes: a8200613c8c9 ("ion: Protect kref from userspace manipulation")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/staging/android/ion/ion-ioctl.c |    8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

--- a/drivers/staging/android/ion/ion-ioctl.c
+++ b/drivers/staging/android/ion/ion-ioctl.c
@@ -64,14 +64,10 @@ static struct ion_handle *pass_to_user(s
 }
 
 /* Must hold the client lock */
-static int user_ion_handle_put_nolock(struct ion_handle *handle)
+static void user_ion_handle_put_nolock(struct ion_handle *handle)
 {
-	int ret;
-
 	if (--handle->user_ref_count == 0)
-		ret = ion_handle_put_nolock(handle);
-
-	return ret;
+		ion_handle_put_nolock(handle);
 }
 
 static void user_ion_free_nolock(struct ion_client *client,


