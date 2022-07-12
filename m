Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53D00CCA482
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jul 2022 16:02:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234101AbiGLQCR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jul 2022 12:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233286AbiGLQCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 12:02:10 -0400
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76818C766D
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 09:02:08 -0700 (PDT)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4Lj59S3m2Kz9sSd;
        Tue, 12 Jul 2022 18:02:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dragonslave.de;
        s=MBO0001; t=1657641724;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=83iQhRFKVk1mc+/DOJ47+bxvoNcFz6OLK68kEiS8wTA=;
        b=bLJxcGyYai20DSm3qcZsuWw4YRwg12OFYm3BAPGlShK9efmnxmZjmuCdzZgzxktlwV+mtK
        K8/UI1od8ErNoq5FIXlNtLsJW5dMLpVs10hQz7PDxJHACQHfXLQJ3RO7TRPKbEvoKJ9zre
        8D657QjhZmGfUlg6duJfspdwNEqJEAHmtv+M9FqvU4FbKD2ilMjy5z24r0HcHmRfHggzfq
        yRZ5/0jAd+8LS1um0eeCnXvnGBW0Gl2jryorint0L5GwOZmRJVf0/TWc4OKBK59tZJafkO
        ICqtrHUN/bOTI3YE6jkfoYwwsswQhBUuyUaRZYAnzxPONYuXVHhz+tp3jomwFQ==
Message-ID: <46fd7a73-06fd-a8a0-8530-0ecf9b18c08d@dragonslave.de>
Date:   Tue, 12 Jul 2022 18:02:03 +0200
MIME-Version: 1.0
Content-Language: en-US
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc:     Daniel Exner <dex@dragonslave.de>
From:   Daniel Exner <dex@dragonslave.de>
Subject: Regression in v5.19-rc4 Sound Distortion
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4Lj59S3m2Kz9sSd
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,


(please keep me CC as I am currently not subscribed to LKML)


Since  v5.19-rc4 this box got some *loud* distorting sound on boot and 
after some time without any sound if something plays sound again from 
the integrated speakers in my monitor.


I managed to bisect this down to:

> commit 202773260023b56e868d09d13d3a417028f1ff5b
> Author: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> Date:   Fri Jun 17 15:24:02 2022 +0300
>
>    PM: hibernate: Use kernel_can_power_off()
>

Reverting that commit on top of v5.19-rc6 does indeed fix the problem here.

Any ideas?


Greetings,

Daniel

