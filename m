Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EF7CC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 16 May 2022 10:28:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbiEPK2c (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 May 2022 06:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242602AbiEPK1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 06:27:38 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D28E71276B;
        Mon, 16 May 2022 03:27:35 -0700 (PDT)
Message-ID: <20220516102615.884180377@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652696854;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=CoGlZyFL3pAxXiJaU2U3vnxv5onfr/2AaV/j+pIZ2Ys=;
        b=xriXfmZSJCuMcwZ8H+eZ/eLkKxees/NqxQdyw5eu71hEm8fC6VbGhCOaYMRRkiRVKB68u4
        ZdsZMW2dsNFYT4773gpVoBiY+E4AIU0JvWIDLQ4PmItCAbLP46K6vyR48dcNPG6LeEDjYU
        lvfq8rOlX6lOtbf+2oZyMd8mDRQ3nCXlvKEvDcYWCNY3fGRGWRKM8R+fY6eo1EwmVZ+Jpd
        Xnu32UcP/kqMIr50QltJ6aI+QRCmGRkRZR4cBKl3zwYHl4Y52ZbZKzxS1v9HPqKkhcO7ic
        wnlGlmhUNeMeVIBfYxX20de1vsIWVgledsAt6oTmNKgFncyEku27UD0CQJ1VXA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652696854;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=CoGlZyFL3pAxXiJaU2U3vnxv5onfr/2AaV/j+pIZ2Ys=;
        b=RVVbPdZRF77TpW3NSEgwFohkWfCfj+Xz1oObfQ3beB5xCgOzihZ61UDBw9t8eoPwUGq/sj
        Y0UhoMBz7SVNDRAA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     linux-spdx@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@lst.de>
Subject: [patch 8/9] scripts/spdxcheck: Exclude dot files
References: <20220516101901.475557433@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 16 May 2022 12:27:33 +0200 (CEST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

None of these files

     .clang-format, .cocciconfig, .get_maintainer.ignore, .gitattributes,
     .gitignore, .mailmap

have copyrightable content. They are configuration files which use a
publicly documented format.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 scripts/spdxexclude |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/scripts/spdxexclude
+++ b/scripts/spdxexclude
@@ -2,6 +2,12 @@
 #
 # Patterns for excluding files and directories
 
+# Ignore dot files:
+# .clang-format, .cocciconfig, .get_maintainer.ignore
+# .gitattributes, .gitignore, .mailmap
+# do not really have copyrightable content
+.*
+
 # Ignore the license directory and the licensing documentation which would
 # create lots of noise for no value
 LICENSES/

