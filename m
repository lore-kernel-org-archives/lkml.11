Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50B05C25B06
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Aug 2022 05:29:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbiHNF3a (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Aug 2022 01:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiHNF31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 01:29:27 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7DB528E32
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 22:29:26 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id x21so5935308edd.3
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 22:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc;
        bh=z2gFosycv/4d8F4IH6M5EFvOMVfX/xiPl+lWjQfsKQI=;
        b=W/iu19BBOsHo5x+7WgNm+j5DcNaMWVDKs2QXr36IbTcPalv7Fc9qzOo7sbZkbMh3Yl
         1eRfMJKRAzlO9RMuJn/AEBfOhguEZDBAFcoqCSaOuFWNQYZBREyJY8A7ZBWBM6GU4Mhj
         qfMgG3IZvqa37LUmYQUUbhzrcT+x3RgQtKtquBiCF0AhgeC2m7zMHx9C8h6w4He7NxpD
         eeY+aIo+G8hhoU8MsB0ibIICQvcacJHqao36NqetlzLR5wPZF9hS45UeRX3PO3VBlYQh
         s3TFtvOAfdj3loD1MEcJ2+0x0HLfD+BCrVtpuaknhJAltgNql9n3zsybQgZ3LCmij7cG
         VuNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc;
        bh=z2gFosycv/4d8F4IH6M5EFvOMVfX/xiPl+lWjQfsKQI=;
        b=paY25WdrqgodCks1bcNQPMh5wj/0vNOjf98aAUzvuFD7dMwipmBg9clATsjqRNjtRt
         c6wbq9jLILhx89jfn299GeaqpSq1TF9Q7jXZGLhIRaKiN4Lj0MX9b76hpPbKYpBigqHM
         r85gKGlVFWP+WGACZ/HRJtqrQfJcU+x0Clco7czMyli2+jEba1fE22tOuodZAR9b+uH2
         bBKw1eU+Wt7eMLrNaiKARTJjsWsEN2c/omwBw7/gCIzYVkpbXeLp5jcoELAMA5z+zN0m
         w0VHKdUUwKREKpBU4J7kaMa0KUmuJY/umRZtrgpYiYw/SfQh7S93w3L3Vhi9aXXM6ZUk
         7I9w==
X-Gm-Message-State: ACgBeo0Dbc2MYnaw7qDH704DBLQRfck2fYJbyUlnTZNOXHYVq4KpdUC/
        iIM5pv5+p1qQaP+t+5lyBeoByXOlwhTD9S66OtSa8qZ+2Rc=
X-Google-Smtp-Source: AA6agR4Zm0pXDSUVmsdakCMdUl9AOZsFWrKuKbCs2pVWcSiyIIRvjoK1KY8/zG65iiTAVE9tBE9y0qhAQMf6wmdI8BA=
X-Received: by 2002:aa7:d6da:0:b0:43f:99fb:f3aa with SMTP id
 x26-20020aa7d6da000000b0043f99fbf3aamr9368477edr.370.1660454965409; Sat, 13
 Aug 2022 22:29:25 -0700 (PDT)
MIME-Version: 1.0
From:   ravin goyal <ravirocks1021@gmail.com>
Date:   Sun, 14 Aug 2022 10:59:14 +0530
Message-ID: <CANU0Mn3y+HN+u2eLiq7MxQ9mw0w68Mhnzw6Zs=AK-_rc53hHaw@mail.gmail.com>
Subject: unsubsribe
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

unsubscribe linux-kernel
