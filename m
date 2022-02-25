Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 400BCC4332F
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Feb 2022 20:45:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236340AbiBYUqA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Feb 2022 15:46:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237230AbiBYUpw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 15:45:52 -0500
Received: from ixit.cz (ip-94-112-206-30.net.upcbroadband.cz [94.112.206.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26F751FEF9C;
        Fri, 25 Feb 2022 12:45:15 -0800 (PST)
Received: from [10.0.0.111] (_gateway [10.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id 3185120056;
        Fri, 25 Feb 2022 21:45:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
        t=1645821913;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=4i5elKgbepnJ0t2xjTZt4bJqTmNRYyzdF9yJBgoWMFo=;
        b=i8lhg4oPlY4GalyLXY4GI2/yhh03+A5fpPm3oL6x8IJc3NqoZkDMFlQ7C4WBwmBo1987P6
        bqfYYaQTWoIE2OYKKCofRtG0zg3Lhq+h3PmGMjgUnnBMhJlRXl0cbZIWeaRY59v5syqDOT
        vOYcpTsDwb3nn8HgIVOxFllbv9EJ7Pc=
Date:   Fri, 25 Feb 2022 21:45:07 +0100
From:   David Heidelberg <david@ixit.cz>
Subject: Re: [PATCH 1/2] dt-bindings: soc: qcom: add qcom,tcsr bindings
To:     ansuelsmth@gmail.com
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org
Message-Id: <7BOV7R.G732UOG2LM5N@ixit.cz>
X-Mailer: geary/40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

s/GPL-2.0/GPL-2.0-only/
David


