Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7C4BC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 17 May 2022 02:04:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236717AbiEQCEh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 May 2022 22:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239928AbiEQCEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 22:04:20 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2A01446165
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 19:04:10 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 265C31E80D93;
        Tue, 17 May 2022 09:57:54 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 2MPcelc2wIF6; Tue, 17 May 2022 09:57:51 +0800 (CST)
Received: from localhost.localdomain (unknown [219.141.250.2])
        (Authenticated sender: chuanjian@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 878B11E80D80;
        Tue, 17 May 2022 09:57:51 +0800 (CST)
From:   Dong Chuanjian <chuanjian@nfschina.com>
To:     rdunlap@infradead.org
Cc:     Kernel@nfschina.com, changbin.du@intel.com, chuanjian@nfschina.com,
        linux-kernel@vger.kernel.org, masahiroy@kernel.org,
        nathan@kernel.org, ndesaulniers@google.com
Subject: Re: [PATCH] scripts:modify output format
Date:   Tue, 17 May 2022 10:04:03 +0800
Message-Id: <20220517020404.4195-1-chuanjian@nfschina.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <4aeee9a4-e8e1-bcac-1ebb-f2b8860ba363@infradead.org>
References: <4aeee9a4-e8e1-bcac-1ebb-f2b8860ba363@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The compiler does not have warnings, but the definition of the output variable is "unsigned int"，So there will be this patch.


