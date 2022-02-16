Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4DBEC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Feb 2022 15:41:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235565AbiBPPmD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Feb 2022 10:42:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230491AbiBPPmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 10:42:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC21A13F34;
        Wed, 16 Feb 2022 07:41:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B4D3461A0C;
        Wed, 16 Feb 2022 15:41:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE600C004E1;
        Wed, 16 Feb 2022 15:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645026107;
        bh=rIvI7RHN7VOk5k6Knj5isUnfKRnIoIua2chTqpLtNMY=;
        h=From:To:Cc:Subject:Date:From;
        b=ObYB7N1U6ZNVSlWbGgsfnEjxEACv+QQo4sBUXVEnmYXC0XoG16edxefvJJkuSHBky
         JbYNXHb7X/IG96+PsGoZ1NDE6/zzxqaDTFSp8TE1yCkOSg6taK+cdM8GWnn658DTZv
         PG7dSIFCmP7aL7orFFm+aS1ShbO8g82FHnxiIV3VORXzqEY33pvxk+hjX1k0YdoU89
         yKkClR1a1rvmDeWMlTfR/AvSEMQIZXV0aJQ5pAzSoUY+sFI/VZIwxVik/gcWvF/+Nm
         +9AKIPcsCmFydGTxv/2oTnk0HfgN1RAj20QqTs37cwUbiGJ7VNtOlrajjVdkuCHhFe
         mXu7wInWmz6HQ==
From:   Nathan Chancellor <nathan@kernel.org>
To:     cgel.zte@gmail.com
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        chi.minghao@zte.com.cn
Subject: Re: [PATCH] soc/qcom: use struct_size over open coded arithmetic
Date:   Wed, 16 Feb 2022 08:41:19 -0700
Message-Id: <20220216154119.240072-1-nathan@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am forwarding along this build report from the kernel test robot due
to a bug in their system. As I am sure you will figure out soon enough,
this patch was not even build tested.

Cheers,
Nathan
